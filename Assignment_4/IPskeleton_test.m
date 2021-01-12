clc;                                  % clear the command window
close all;                            % close open figure windows    
clear;                                % clear workspace

imname = 'nutsbolts';
inputfile = ['input_images/', imname, '.tif'];          
f = imread(inputfile);                  % read input image

B_square = logical([1 1 1; 1 1 1; 1 1 1]);

% % Example from the slides (with borders added)
% f = logical([   0 0 0 0 0 0 0;
%                 0 1 0 0 0 0 0;
%                 0 0 1 1 0 0 0;
%                 0 0 1 1 0 0 0;
%                 0 0 1 1 1 0 0;
%                 0 0 1 1 1 0 0;
%                 0 1 1 1 1 1 0;
%                 0 1 1 1 1 1 0;
%                 0 1 1 1 1 1 0;
%                 0 1 1 1 1 1 0;
%                 0 1 1 1 1 1 0;
%                 0 0 0 0 0 0 0;]);

skeleton = IPskeletondecomp(f, B_square);
reconstruction = IPskeletonrecon(skeleton, B_square);

% Calculate the difference between the input and the reconstruction
difference = sum(abs(double(f) - double(reconstruction)), 'all');

% Show input, skeleton, result and difference
figure;
subplot(221);
imshow(f)
title("input image");
subplot(222);
imshow(reconstruction)
title("reconstruction");
subplot(223);
imshow(skeleton)
title("IPskeletondecomp");
subplot(224);
imshow(f-reconstruction)
title("difference=" + difference);

% Save current plot
saveas(gcf, ['output_plots/', imname, '_skeleton_test.svg']);
exportgraphics(gcf, ['output_plots/', imname, '_skeleton_test.png']);

% Plot and save individual images
figure;
imshow(reconstruction)
saveas(gcf, 'output_plots/skeleton_reconstruction.svg');
figure;
imshow(skeleton)
saveas(gcf, 'output_plots/skeleton_skeleton.svg');
figure;
imshow(f-reconstruction)
saveas(gcf, 'output_plots/skeleton_difference.svg');



