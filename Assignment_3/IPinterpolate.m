function v = IPinterpolate(I, P, offset, interpolation)
% IPinterpolate Interpolate image pixel for image using given method.
% Arguments:
%       I: Input image
%       P: Coordinates of pixel with unknown intensity value; in original 
%           (i.e. non-transformed) coordinate space. e.g. coordinates might
%           have decimals.
%       interpolation: one of 
%           ('none' | 'nearest' | 'bilinear')
%           meaning no interpolation, nearest neighbor interpolation and
%           bilinear interpolation, respectively.
[M, N] = size(I);
switch interpolation
    %% Nearest neighbor interpolation
    % Finds the nearest pixel in the inverse mapping using `ceil`.
    case 'nearest'
        % Make sure within bounds
        Po = P + offset;
        x = min(max(1, Po(1)), N);
        y = min(max(1, Po(2)), M);
        v = I(round(y), round(x));
    case 'bilinear'
    %% Bilinear interpolation
    % See Bilinear interpolation Wikipedia page for used terminology and 
    % also https://bit.ly/3o3vcxD for parts of implementation.
        Po = P + offset;
        x = Po(1);
        y = Po(2);
        % Any values out of acceptable range
        x(x < 1) = 1;
        x(x > N - 0.001) = N - 0.001;
        x1 = floor(x);
        x2 = x1 + 1;
        y(y < 1) = 1;
        y(y > M - 0.001) = M - 0.001;
        y1 = floor(y);
        y2 = y1 + 1;
        % Neighboring Pixels
        Q = [I(y1,x1); I(y1,x2); I(y2,x1); I(y2,x2);];
        % Pixels Weights
        b = [(y2-y)*(x2-x); (y2-y)*(x-x1); (x2-x)*(y-y1); (y-y1)*(x-x1);];
        v = dot(b, Q);
    otherwise % no interpolation, i.e. 'none'
        % if this pixel maps to an original pixel
        if mod(P(1), 1) == 0 && mod(P(2), 1) == 0
            v = I(P(2), P(1));
        else % otherwise pad with zeros; no interpolation
            v = 0;
        end
end
end

