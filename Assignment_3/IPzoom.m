function zoomedImage = IPzoom(I, factor)
% IPzoom Zooms an image by a factor of `factor`, which
% must be a (positive) integer, i.e. upsamplingFactor >= 1. Function zooms
% image by replicating pixels.
% Arguments:
%   I: input image to zoom
%   factor: factor to zoom with. Must be an integer.
assert(isinteger(factor), 'factor must be an integer (was %d)', factor);
zoomedImage = IPscaling_transformation(I, double(factor), 'nearest');
end
