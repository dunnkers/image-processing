clc;
imname = 'characters';
inputfile = ['input_images/', imname,'.tif'];          
f = imread(inputfile);

% compute its centered Fourier spectrum
fft2() %fast fourier transform 2D
fftshift() %Shift zero-frequency component to center of spectrum

% Display the spectrum.

% Use your result in (a) to compute the average value of the image.
