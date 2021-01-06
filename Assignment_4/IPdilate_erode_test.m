clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'wirebondmask';
inputfile = ['input_images/', imname, '.tif'];          
f = imread(inputfile);                  % read input image

figure;
% Original image
colormap(gray(256));
imagesc(f);
axis equal;
axis tight;
title({'Original `wirebondmask` image', ' '});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write current figure to file
all_file = ['output_plots/', imname,'_original','.svg'];
saveas(gcf, all_file);
fprintf('\nComplete image has been saved in file %s\n', all_file);

% Structuring Elements
B_cross     = logical([0 1 0; 1 1 1; 0 1 0]);
B_square    = logical([1 1 1; 1 1 1; 1 1 1]);
B_circle    =  logical( [0 0 1 0 0;
                         0 1 1 1 0;
                         1 1 1 1 1;
                         0 1 1 1 0;
                         0 0 1 0 0]);
    
% Dilation
figure;
subplot(241);
colormap(gray(256));
imagesc(f);
axis equal;
axis tight;
title({'Original `wirebondmask` image', ' '});
% Dilation w/ `Cross` SE
subplot(242);
g = IPdilate(f, B_cross);
colormap(gray(256));
imagesc(g);
axis equal;
axis tight;
title({'Dilated `wirebondmask` image', '`Cross` SE'});

subplot(246);
imagesc(B_cross);
axis equal;
axis tight;
title({'`Cross` SE'});
% Square
subplot(243);
g = IPdilate(f, B_square);
colormap(gray(256));
imagesc(g);
axis equal;
axis tight;
title({'Dilated `wirebondmask` image', '`Square` SE'});

subplot(247);
imagesc(B_square);
axis equal;
axis tight;
title({'`Square` SE'});
% Circle
subplot(244);
g = IPdilate(f, B_circle);
colormap(gray(256));
imagesc(g);
axis equal;
axis tight;
title({'Dilated `wirebondmask` image', '`Circle` SE'});

subplot(248);
imagesc(B_circle);
axis equal;
axis tight;
title({'`Circle` SE'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write current figure to file
all_file = ['output_plots/', imname,'_all','_dilate', '_SE=cross', '.svg'];
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 0.75 1.00])
saveas(gcf, all_file);
fprintf('\nComplete image has been saved in file %s\n', all_file);
