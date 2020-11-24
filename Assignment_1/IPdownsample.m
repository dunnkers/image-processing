function downsampledImage = IPdownsample(I, factor)
% IPdownsample Down-samples an image by a factor of `factor`, which
% must be a (positive) integer, i.e. shrinkFactor >= 1. Function shrinks
% the image by means of averaging neighbours.
% Arguments:
%   I: input image to downsample
%   factor: factor to shrink with. Must be an integer.
assert(~isinteger(factor), 'factor must be an integer (was %d)', factor);

% Cast to integers
M = size(I, 1); % height
N = size(I, 2); % width

% Downsampled (`_ds`) image dimensions
M_ds = floor(M / factor);
N_ds = floor(N / factor);
I_ds = zeros(M_ds, N_ds);

% Find average pixels over neighborhood
for i = 1:M_ds
   for j = 1:N_ds
        start_i = (i - 1) * factor + 1;
        end_i   = i * factor;
        start_j = (j - 1) * factor + 1;
        end_j   = j * factor;
        neighborhood = I(start_i:end_i, start_j:end_j);
        I_ds(i, j) = mean(mean(neighborhood));
   end
end

% Return downsampled image in uint8 format
downsampledImage = uint8(I_ds);
end

