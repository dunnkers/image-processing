clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'characters';
inputfile = ['input_images/', imname,'.tif'];          
f = imread(inputfile);                  % read input image

figure;
imshow(f);
[M, N] = size(f); % height, width
D0 = 60;
n = 2;
H = IPbhpf(D0, n, M, N);
I = IPftfilter(f, H);
figure;
imshow(I);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Write current figure to file
% all_file = ['output_plots/', imname,'_all','_bhpf', '.svg'];
% saveas(gcf, all_file);
% fprintf('\nComplete image has been saved in file %s\n', all_file);



function g = IPftfilter(x, H)
% IPftfilter Perform convolution filtering.
%   Arguments:
%       x = input image
%       H = transfer function
[M, N] = size(x); % height, width

% Determine padding sizes (1)
P = 2*M; % Eq (4-102)
Q = 2*N; % Eq (4-103)

% Form a padded image using zero-padding (2)
f_p = zeros(P, Q);
f_p(1:M, 1:N) = im2double(x); % copy over original image

% Center the Fourier Transform (3)
[X, Y] = meshgrid(1:P, 1:Q); % TODO: should swap P AND Q??
c = -1^(X + Y); % centering term
f_c = f_p * c;  % multiply by $-1^(x + y)$

% Compute DFT (4)
F = fftshift(fft2(f_c));

% Form the product G(u, v) (6)
G = F;
G(1:M, 1:N) = F(1:M, 1:N) .* H;

% Obtain filtered image
g_p = real(ifft2(ifftshift(G))) * c; % Compute inverse DFT of G(u, v)
g = g_p(1:M, 1:N);
end

function H = IPbhpf(D0, n, M, N)
% IPbhpf Butterworth highpass filter implementation.
%   Input arguments:
%       D0 = cutoff frequency
%       n = order
%       M x N = size
%   Output arguments:
%       H = transfer function

% P = 2*M; % Eq (4-102)
% Q = 2*N; % Eq (4-103)
% u = 0:(P - 1) - P/2; 
% v = 0:(Q - 1) - Q/2;

u = 0:(M - 1); 
v = 0:(N - 1);
idx = find(u > M/2);
u(idx) = u(idx) - M;
idy = find(v > N/2);
v(idy) = v(idy) - N;

% Make coordinate grid
[V, U] = meshgrid(v, u); 
  
% Distance between a point (u, v) in the frequency domain and the center
% of the P x Q frequency rectangle (Eq 4-112)
D = sqrt(U.^2 + V.^2); 
  
% Transfer function of Butterworth highpass filter (BHPF) (Eq 4-121)
H = 1 ./ (1 + (D0 ./ D) .^ (2 * n));
end

