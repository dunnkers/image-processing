function upsampledImage = IPupsample(I, factor)
% IPupsample Up-samples an image by a factor of `factor`, which
% must be a (positive) integer, i.e. upsamplingFactor >= 1. Function up-samples
% image by introducing zeros.
% Arguments:
%   I: input image to up-sample
%   factor: factor to grow with. Must be an integer.
assert(isinteger(factor), 'factor must be an integer (was %d)', factor);
It = IPscaling_transformation(I, double(factor), 'none');
upsampledImage = uint8(It * 2^8); % normalize back to 8-bit int image.
end
