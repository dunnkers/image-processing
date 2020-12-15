clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'plant';
inputfile = ['input_images/', imname,'.tif'];          
f = imread(inputfile);                  % read input image

figure;
% Original image
colormap(gray(256));
imagesc(f);
axis equal;
axis tight;
title({'Original `plant` image', ' '});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write current figure to file
all_file = ['output_plots/', imname,'_original','.svg'];
% set(gcf, 'PaperUnits', 'normalized')  
% set(gcf, 'PaperPosition', [0 0 1.75 0.40])
saveas(gcf, all_file);
fprintf('\nComplete image has been saved in file %s\n', all_file);

% Pyramid decomposition
figure;
[M, N] = size(f); % height, width
J = 3;
sigma = 1.0;
g = IPpyr_decomp(f, J, sigma);
colormap(gray(256));
save('IPpyr_decomp_data-J=3,sigma=1.0.mat', 'g')
imagesc(g);
axis equal;
axis tight;
title({'pyramid decomposition', '(J=3, sigma=1.0)'});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write current figure to file
all_file = ['output_plots/', imname,'_all','_pyr-decomp', '.svg'];
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 1.75 1.00])
saveas(gcf, all_file);
fprintf('\nComplete image has been saved in file %s\n', all_file);

