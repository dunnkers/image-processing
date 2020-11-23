function [downscaledImage] = IPdownsample(I, shrinkFactor)
% IPdownsample Down-samples an image by a factor of `shrinkFactor`, which
% must be a (positive) integer, i.e. shrinkFactor >= 1. Function shrinks
% the image by means of averaging neighbours.
% Arguments:
%   I: input image to downscale
%   shrinkFactor: factor to shrink with. Must be an integer.
assert(~isinteger(shrinkFactor), 'shrinkFactor must be an integer (was %d)', shrinkFactor);

% Cast to integers
shrinkFactor = uint8(shrinkFactor);
M = uint8(size(I, 1));
N = uint8(size(I, 2));

% Downsampled (`_ds`) image dimensions
M_ds = M / shrinkFactor;
N_ds = N / shrinkFactor;
I_ds = zeros(M_ds, N_ds);


downscaledImage = I_ds;
end

