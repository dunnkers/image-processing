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
B_cross     = [0 1 0; 1 1 1; 0 1 0];
B_square    = [1 1 1; 1 1 1; 1 1 1];
B_circle    =   [0 0 1 0 0;
                 0 1 1 1 0;
                 1 1 1 1 1;
                 0 1 1 1 0;
                 0 0 1 0 0];
    
% Dilation
figure;
g = IPdilate(f, B_cross);
colormap(gray(256));
imagesc(g);
axis equal;
axis tight;
title({'Dilated `wirebondmask` image', '`Cross` SE'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write current figure to file
all_file = ['output_plots/', imname,'_all','_dilate', '_SE=cross', '.svg'];
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 0.75 1.00])
saveas(gcf, all_file);
fprintf('\nComplete image has been saved in file %s\n', all_file);
