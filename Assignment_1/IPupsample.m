function upsampledImage = IPupsample(I, factor)
% IPupsample Up-samples an image by a factor of `factor`, which
% must be a (positive) integer, i.e. upsamplingFactor >= 1. Function up-samples
% image by introducing zeros.
% Arguments:
%   I: input image to up-sample
%   factor: factor to grow with. Must be an integer.
assert(~isinteger(factor), 'factor must be an integer (was %d)', factor);

% Cast to integers
M = size(I, 1); % height
N = size(I, 2); % width

% Up-sampled (`_us`) image dimensions
M_us = floor(M * factor);
N_us = floor(N * factor);
I_us = zeros(M_us, N_us);

% Find average pixels over neighborhood
for i = 1:M
   for j = 1:N
        pos_i = (i - 1) * factor + 1;
        pos_j = (j - 1) * factor + 1;
        I_us(pos_i, pos_j) = I(i, j);
   end
end

% Return upsampled image
upsampledImage = uint8(I_us);
end

