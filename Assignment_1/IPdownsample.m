function downscaledImage = IPdownsample(I, shrinkFactor)
% IPdownsample Down-samples an image by a factor of `shrinkFactor`, which
% must be a (positive) integer, i.e. shrinkFactor >= 1. Function shrinks
% the image by means of averaging neighbours.
% Arguments:
%   I: input image to downscale
%   shrinkFactor: factor to shrink with. Must be an integer.
assert(~isinteger(shrinkFactor), 'shrinkFactor must be an integer (was %d)', shrinkFactor);

% Cast to integers
M = size(I, 1); % height
N = size(I, 2); % width

% Downsampled (`_ds`) image dimensions
M_ds = floor(M / shrinkFactor);
N_ds = floor(N / shrinkFactor);
I_ds = zeros(M_ds, N_ds);

% Find average pixels over neighborhood
for i = 1:M_ds
   for j = 1:N_ds
        start_i = (i - 1) * shrinkFactor + 1;
        end_i   = i * shrinkFactor;
        start_j = (j - 1) * shrinkFactor + 1;
        end_j   = j * shrinkFactor;
        neighborhood = I(start_i:end_i, start_j:end_j);
        I_ds(i, j) = mean(mean(neighborhood));
   end
end
downscaledImage = I_ds;
end

