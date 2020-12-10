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

% average of the image
average_image = mean(f, 'all');

% average of the image proportional to the zero-frequency term (Eq.4-92)
[M, N] = size(f);
average_image_proportional = M*N*mean(f, 'all');

% zero-frequency term in the result of (a)
spectrum = abs(fftshift(fft2(f)));
zero_frequency_term_of_a = spectrum(M/2+1,N/2+1);

% average of the original image using result of (a)
average_image_using_a = spectrum(M/2+1,N/2+1)/(M*N);