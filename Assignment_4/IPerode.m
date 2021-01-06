function Iero = IPerode(I, B)
% IPerode Erodes a binary image using some structuring element.
%   Arguments:
%       I: input image to erode. Must be binary, i.e. have logical values.
%       B: structuring element (SE). Must have odd dimensions and also be 
%       binary, i.e. have logical values. Its origin is automatically set 
%       at its centerpoint.
%   Returns: eroded image
Iero = IPmorph(I, B, 'erode');
end