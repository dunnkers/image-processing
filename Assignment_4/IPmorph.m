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

% Construct a 1-padding around image
P = padarray(zeros(M, N), [pad_y, pad_x], 1, 'both');

% Isolate foreground pixels
[A1, A2] = find(I);
[B1, B2] = find(B);
[P1, P2] = find(P);
% shift SE coordinates such that origin is at center
B1 = B1 - pad_y;
B2 = B2 - pad_x;
% shift padding coordinates
P1 = P1 - pad_y;
P2 = P2 - pad_x;
% form sets of coordinates
A = [A1 A2]; 
B = [B1 B2];
P = [P1 P2];
% Loop image foreground pixels
Imorph = false(M, N);
for i=1:length(A)
    z = A(i, :);
    switch type
        case 'erode'  % erode:  1 iff SE 'fits' neighborhood exactly.
            Bz = B + (z - 1);
            subset = ismember(Bz, [A; P], 'rows');
            value = all(subset);
        case 'dilate' % dilate: 1 iff SE 'hits' any in neighboorhood.
            Bhat = -(B - 1) + 1; % Reflect. correct for Matlab indexing.
            Bz = Bhat + (z - 1);
            subset = ismember(Bz, A, 'rows');
            value = any(subset);
    end
    Imorph(z(1), z(2)) = value;
end
end