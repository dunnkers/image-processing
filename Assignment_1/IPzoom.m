function zoomedImage = IPzoom(I, factor)
% IPzoom Zooms an image by a factor of `factor`, which
% must be a (positive) integer, i.e. upsamplingFactor >= 1. Function zooms
% image by replicating pixels.
% Arguments:
%   I: input image to zoom
%   factor: factor to zoom with. Must be an integer.
assert(~isinteger(factor), 'factor must be an integer (was %d)', factor);

% Cast to integers
M = size(I, 1); % height
N = size(I, 2); % width

% Up-sampled (`_zoom`) image dimensions
M_zoom = floor(M * factor);
N_zoom = floor(N * factor);
I_zoom = zeros(M_zoom, N_zoom);

% Find average pixels over neighborhood
for i = 1:M
   for j = 1:N
        start_i = (i - 1) * factor + 1;
        end_i   = i * factor;
        start_j = (j - 1) * factor + 1;
        end_j   = j * factor;
        I_zoom(start_i:end_i, start_j:end_j) = I(i, j);
   end
end

% Return upsampled image
zoomedImage = uint8(I_zoom);
end

