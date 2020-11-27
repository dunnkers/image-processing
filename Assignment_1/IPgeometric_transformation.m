function I_transformed = IPgeometric_transformation(I, A)
% IPgeometric_transformation Transforms image using given affine
% transformation matrix.
% Arguments:
%       I: Input image
%       A: Affine transformation matrix

% Image size
M = size(I, 1); % height
N = size(I, 2); % width

% Map coordinates to new values
for x = 1:M
   for y = 1:N
       coords = [x, y, 1];
       transformed = coords * A;
   end
end

I_transformed = I;
end

