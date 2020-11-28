function downsampledImage = IPdownsample(I, factor)
% IPdownsample Down-samples an image by a factor of `factor`, which
% must be a (positive) integer, i.e. factor >= 1.
% Arguments:
%   I: input image to downsample
%   factor: factor to shrink with. Must be an integer.
assert(isinteger(factor), 'factor must be an integer (was %d)', factor);
It = IPscaling_transformation(I, 1/double(factor), 'nearest');
downsampledImage = uint8(It * 2^8); % normalize back to 8-bit int image.
end

