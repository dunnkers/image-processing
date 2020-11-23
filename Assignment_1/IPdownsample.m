function [downscaledImage] = IPdownsample(I, shrinkFactor)
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
M_ds = M / shrinkFactor;
N_ds = N / shrinkFactor;
I_ds = zeros(round(M_ds), round(N_ds));


downscaledImage = I_ds;
end

