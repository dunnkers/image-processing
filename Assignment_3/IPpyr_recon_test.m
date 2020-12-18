clc;                                  % clear the command window
close all;                            % close open figure windows      

% Define J and sigma
J = 3;
sigma = 1.0;

% Load initial input image
imname = 'plant';
inputfile = ['input_images/', imname,'.tif'];          
f = imread(inputfile);                  % read input image
f = im2double(f);
[M, N] = size(f);
assert(M==N);

% % Decompose the image
% g = IPpyr_decomp(f, J, sigma);

% Load decomposed image from file
mat = load('IPpyr_decomp_data-J=3,sigma=1.0.mat');
g = mat.g;

% Pyramid reconstruction
g2 = IPpyr_recon(g, J, sigma);

% Show results
figure;
subplot(121);
imshow(f)
subplot(122);
imshow(g2)

% Write current figure to file
saveas(gcf, 'output_plots/IPpyr_recon_test_partial.svg');

% Nicer output image but requires Matlab 2020a or above
% exportgraphics(gcf, 'output_plots/IPpyr_recon_test_partial.png');

% turn the next two lines off if you want to compare double images
g2 = im2uint8(g2);
f = imread(inputfile);

% compute absolute error between f and g2 + create difference image
diffImage = abs(f - g2);
error = sum(abs(f - g2), 'all') / (M * N)

% show results
figure;
subplot(131);
imshow(f)
subplot(132);
imshow(g2)
subplot(133);
imshow(diffImage)

% Write current figure to file
saveas(gcf, 'output_plots/IPpyr_recon_test.svg');

% Nicer output image but requires Matlab 2020a or above
% exportgraphics(gcf, 'output_plots/IPpyr_recon_test.png');
