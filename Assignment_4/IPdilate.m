function Idil = IPdilate(I, B)
% IPdilate Dilates a binary image using some structuring element.
%   Arguments:
%       I: input image to dilate. Must be binary, i.e. have logical values.
%       B: structuring element (SE). Must have odd dimensions and also be 
%       binary, i.e. have logical values. Its origin is automatically set 
%       at its centerpoint.
%   Returns: dilated image
Idil = IPmorph(I, B, 'dilate');
end