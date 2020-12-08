clc;
imname = 'characters';
inputfile = ['input_images/', imname,'.tif'];          
f = imread(inputfile);
f = im2double(f);
x = f;

% compute its centered Fourier spectrum
[M, N] = size(x); % height, width

% Determine padding sizes (1)
P = 2*M; % Eq (4-102)
Q = 2*N; % Eq (4-103)

% Form a padded image using zero-padding (2)
f_p = zeros(P, Q);
f_p(1:M, 1:N) = im2double(x); % copy over original image

% Center the Fourier Transform (3)
[X, Y] = meshgrid(1:P, 1:Q);
c = -1^(X + Y); % centering term, Eq (4-76)
f_c = f_p * c;  % multiply by $-1^(x + y)$

% Compute DFT (4). 
F = fftshift(fft2(f_c)); % Eq (4-67)


% 
% 
% 
% [M, N] = size(f); % height, width
% 
% % Form a padded image using zero-padding (2)
% f_p = zeros(M, N);
% f_p(1:M, 1:N) = f; % copy over original image
% 
% % Center the Fourier Transform (3)
% [X, Y] = meshgrid(1:M, 1:N);
% c = -1^(X + Y); % centering term, Eq (4-76)
% f_c = f_p * c;  % multiply by $-1^(x + y)$
% 
% % Compute DFT (4). 
% F = fftshift(fft2(f_c)); % Eq (4-67)

figure;
imagesc(real(F))

% % Center the Fourier Transform (3)
% [M, N] = size(f);
% [X, Y] = meshgrid(1:M, 1:N);
% c = -1^(X + Y); % centering term, Eq (4-76)
% f_c = f_p * c;  % multiply by $-1^(x + y)$
% 
% DFT = fft2(f_c); %fast fourier transform 2D
% 
% % spectrum = sqrt(real(DFT)^2 + imag(DFT)^2);
% shiftedDFT = fftshift(DFT); %Shift zero-frequency component to center of spectrum
% % spectrumShifted = sqrt(real(shiftedDFT)^2 + imag(shiftedDFT)^2);
% 
% figure;
% plot(abs(DFT))
% figure;
% plot(abs(shiftedDFT))
% figure;
% plot(abs(spectrumShifted))
% 



% Display the spectrum.

% Use your result in (a) to compute the average value of the image.
