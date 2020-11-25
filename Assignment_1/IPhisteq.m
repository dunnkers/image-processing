function hist = IPhisteq(H)


% Cast to integers
M = size(I, 1); % height
N = size(I, 2); % width

% Bins
bins = zeros(1, 2^8); % 8-bit image

% Find average pixels over neighborhood
for i = 1:M
   for j = 1:N
        val = floor(I(i, j)) + 1;
        bins(val) = bins(val) + 1;
   end
end

hist = bins;
end

