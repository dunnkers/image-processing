function g = IPftfilter(x, H)
% IPftfilter Perform convolution filtering. Partially following Eq (4-104) 
% and steps as defined in Section 4.7 'Summary of steps for filtering in 
% the frequency domain'.
%   Arguments:
%       x = input image
%       H = transfer function
%   Output:
%       g = filtered image
[M, N] = size(x); % height, width

% Determine padding sizes
P = 2*M; % Eq (4-102)
Q = 2*N; % Eq (4-103)

% Form a padded image using zero-padding
f_p = zeros(P, Q);
f_p(1:M, 1:N) = im2double(x); % copy over original image

% Compute DFT
F = fftshift(fft2(f_p)); % Eq (4-67)

% Form the product G(u, v)
G = F .* H; % Eq (4-104)

% Obtain filtered image, compute inverse DFT of G(u, v)
g_p = real(ifft2(ifftshift(G))); % among others, IDFT from Eq (4-68)
g = g_p(1:M, 1:N);
end