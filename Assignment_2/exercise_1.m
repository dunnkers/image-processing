clc;
clear;
close all;

imname = 'characters';
inputfile = ['input_images/', imname,'.tif'];          
f = imread(inputfile);
f = im2double(f);

im1 = abs(fft2(f));
im2 = abs(fftshift(fft2(f)));
im3 = log(abs(fft2(f)));
im4 = log(abs(fftshift(fft2(f))));

% Display the spectrum.
figure;
subplot(221);
imshow(im1,[])
title('fft')
subplot(222);
imshow(im2,[])
title('fftshift + fft')
subplot(223);
imshow(im3,[])
title('abs of fft')
subplot(224);
imshow(im4,[])
title('abs of fftshift + fft')

% Write current figure to file
set(gcf, 'PaperUnits', 'normalized')
saveas(gcf, 'output_plots/exercise1.svg');

% Use your result in (a) to compute the average value of the image.

mean(fftshift(fft2(f)), 'all')
mean(f, 'all')

temp = fft2(f);
temp(1,1)
