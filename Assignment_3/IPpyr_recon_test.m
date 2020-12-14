clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'plant';
inputfile = ['input_images/', imname,'.tif'];          
f = imread(inputfile);                  % read input image

% Pyramid decomposition
J = 3;
sigma = 1.0;
g = IPpyr_decomp(f, J, sigma); %this also converts image to double

% Pyramid reconstruction
recon = IPpyr_recon(g, J, sigma);

% Show results
figure;
subplot(121);
f = im2double(f);
imshow(f)
subplot(122);
imshow(recon)
