function Idil = IPdilate(I, B)
% IPdilate Dilates a binary image using some structuring element.
%   Arguments:
%       I: input image to dilate. Must be binary, i.e. have logical values.
%       B: structuring element. Must have odd dimensions. Its origin is
%       automatically set at its centerpoint.
%   Returns: dilated image
% Dimensions
[M, N] = size(I);       % height, width
[Mse, Nse] = size(B);   % height, width
% Ensure image is binary and of logical type
assert(islogical(I));
% Ensure SE has odd dimensions
assert(rem(Mse, 2) ~= 0)
assert(rem(Nse, 2) ~= 0)
% Compute SE origin
origin_y = (Mse + 1) / 2;
origin_x = (Nse + 1) / 2;

% Loop image pixels
Idil = zeros(M, N);
for y=1:M
    for x=1:N
        % Loop SE
        a = (Mse - 1) / 2;
        b = (Nse - 1) / 2;
        result = zeros(Mse, Nse);
        for s=-a:a
            for t=-b:b
                % Skip anything outside the orginal image
                if (y+s < 1 || x+t < 1 || y+s > M || x+t > N)
                    continue;
                end
                result(s+a, t+b) = I(y + s, x + t) && ...
                    B(origin_y + s, origin_x + t);
            end
        end
        Idil(y, x) = any(any(result));
    end 
end
end