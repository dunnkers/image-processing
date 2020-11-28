function [I_eq, h_eq] = IPhisteq(I)
% Histogram equalization algorithm. From (Gonzalez, Woods - Digital Image 
% Processing) chapter 3.3, Eq. 3-15. Follows book terminology.
% Arguments:
%   I: input image to apply histogram-equalization on

% Image size
M = size(I, 1); % height
N = size(I, 2); % width

% Compute histogram and normalized histogram
h = IPhistogram(I);
L = size(h, 2); % amount of intensity levels
assert(sum(h) == M * N);
p_r = h / (M * N); % normalized histogram

% Histogram mapping, i.e. transformation T
T = zeros(1, 2^8); % 8-bit image

% Map each intensity level
for k = 1:L
    % Cumulative probabilities (normalized intensity levels) up to k
    cdf_k = 0;
    for j = 1:k
        cdf_k = cdf_k + p_r(j);
    end
    
    T(k) = (L - 1) * cdf_k;
end

% Map input image intensities to transformed intensities
% Find average pixels over neighborhood
s = zeros(M, N);
for i = 1:M
   for j = 1:N
       r_k = floor(I(i, j)) + 1; % use floor() for integer casting
       s(i, j) = T(r_k);
   end
end
I_eq = uint8(s);
h_eq = IPhistogram(I_eq);
end

