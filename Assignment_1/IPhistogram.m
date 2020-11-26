function h = IPhistogram(I)
% Image size
M = size(I, 1); % height
N = size(I, 2); % width

% Histogram bins
h = zeros(1, 2^8); % 8-bit image

% Count pixels of some intensity value, `r_k`, in the bins
for i = 1:M
   for j = 1:N
        r_k = floor(I(i, j)) + 1; % use floor() for integer casting
        h(r_k) = h(r_k) + 1;
   end
end
end

