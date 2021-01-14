function Imorph = IPmorph(I, B, type)
% IPmorph Applies a morphological transformation to a binary image using 
%         some structuring element. It is assumed the SE origin is at its
%         center.
%   Arguments:
%       I: input image to transform. Must be binary, i.e. have logical values.
%       B: structuring element (SE). Must have odd dimensions and also be 
%       binary, i.e. have logical values. Its origin is automatically set 
%       at its centerpoint.
%       type: morphological transformation type. Can be either 'erode' or
%       'dilate'.
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
% Ensure type argument is of acceptable value
assert(ismember(type, {'erode', 'dilate'}));

% Put padding around original image. Then, SE can freely move around.
pad_y = floor(Mse / 2);
pad_x = floor(Nse / 2);
switch type
    case 'erode'    % pad with 1's in case of erosion
        Ipad = padarray(I, [pad_y, pad_x], 1, 'both');
    case 'dilate'   % pad with 0's in case of dilation
        Ipad = padarray(I, [pad_y, pad_x], 0, 'both');
end

% Loop image pixels
Imorph = false(M, N);
for y=(1:M)+pad_y
    for x=(1:N)+pad_x
        SE_ycoords = (y - pad_y):(y + pad_y);
        SE_xcoords = (x - pad_x):(x + pad_x);
        A = Ipad(SE_ycoords, SE_xcoords);
        
        switch type
            case 'erode'  % erode:  1 iff SE 'fits' neighborhood exactly.
                value = all(A(B));
            case 'dilate' % dilate: 1 iff SE 'hits' any in neighboorhood.
                Bhat = rot90(B, 2)';
                value = any(A(Bhat));
        end
        Imorph(y - pad_y, x - pad_x) = value;
    end 
end
end