function v = IPinterpolate(I, P, interpolation)
% IPinterpolate Interpolate image pixel for image using given method.
% Arguments:
%       I: Input image
%       interpolation: one of 
%           ('none' | 'nearest' | 'bilinear')
%           meaning no interpolation, nearest neighbor interpolation and
%           bilinear interpolation, respectively.
switch interpolation
    case 'nearest' 
        P = ceil(P);
        v = I(P(2), P(1));
    case 'bilinear'
    %% Bilinear interpolation
    % Algorithm from https://en.wikipedia.org/wiki/Bilinear_interpolation
        x1_y1 = ceil(P-1);
        x2_y2 = ceil(P+1);
        x1 = max(x1_y1(1), 1);
        x2 = min(x2_y2(1), size(I, 2));
        y1 = max(x1_y1(2), 1);
        y2 = min(x2_y2(2), size(I, 1));
        system = [1 x1 y1 x1*y1; 1 x1 y2 x1*y2;...
                  1 x2 y1 x2*y1; 1 x2 y2 x2*y2;];
        b = transpose(inv(system))*[1; P(1); P(2); P(1)*P(2);];
        Q = [I(max(y1, 1), max(x1, 1)); I(y2, max(x1, 1));...
             I(max(y1, 1), x2); I(y2, x2);]; % neighbors.
        v = dot(b, Q);
    otherwise % no interpolation, i.e. 'none'
        if all(mod(P, 1) == 0) % if this pixel maps to an original pixel
            v = I(P(2), P(1));
        else % otherwise pad with zeros; no interpolation
            v = 0;
        end
end
end

