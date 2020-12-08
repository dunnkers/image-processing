clc;
imname = 'circuitboard';
inputfile = ['input_images/', imname,'.tif'];          
f = imread(inputfile);
f = im2double(f);

% compute its centered Fourier spectrum
DFT = fft2(f); %fast fourier transform 2D

% spectrum = sqrt(real(DFT)^2 + imag(DFT)^2);
shiftedDFT = fftshift(F); %Shift zero-frequency component to center of spectrum
spectrumShifted = sqrt(real(shiftedDFT)^2 + imag(shiftedDFT)^2);

figure;
plot(abs(DFT))
figure;
plot(abs(shiftedDFT))
figure;
plot(abs(spectrumShifted))




% Display the spectrum.

% Use your result in (a) to compute the average value of the image.
