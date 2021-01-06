function Imorph = IPmorph(I, B, type)
% IPmorph Applies a morphological transformation to a binary image using 
%         some structuring element.
%   Arguments:
%       I: input image to transform. Must be binary, i.e. have logical values.
%       B: structuring element (SE). Must have odd dimensions and also be 
%       binary, i.e. have logical values. Its origin is automatically set 
%       at its centerpoint.
%   Returns: morphologically transformed image

% Dimensions
[M, N] = size(I);       % height, width
[Mse, Nse] = size(B);   % height, width
% Ensure image and SE is binary and of logical type
assert(islogical(I));
assert(islogical(B));
% Ensure SE has odd dimensions
assert(rem(Mse, 2) ~= 0)
assert(rem(Nse, 2) ~= 0)

% Put padding around original image. Then, SE can freely move around.
padding_y = floor(Mse / 2);
padding_x = floor(Nse / 2);
Ipad = padarray(I, [padding_y, padding_x], 0, 'both');

% Loop image pixels
Imorph = false(M, N);
for y=(1 + padding_y):M
    for x=(1 + padding_x):N
        SE_ycoords = (y - padding_y):(y + padding_y);
        SE_xcoords = (x - padding_x):(x + padding_x);
        A = Ipad(SE_ycoords, SE_xcoords);
        
        switch type
            case 'dilate'
                Imorph(y, x) = any(A(B));
            case 'erode'
                Imorph(y, x) = all(A(B));
        end
    end 
end
end