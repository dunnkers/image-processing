function It = IPscaling_transformation(I, A, interpolation)
% IPscaling_transformation Computes an image scaling operation
% using an affine transformation matrix.
% Arguments:
%       I: Input image
%       A: Affine transformation matrix [3x3] of form 
%           [cx 0 0; 0 cy 0; 0 0 1;]
%       interpolation: one of 
%           ('none' | 'nearest' | 'bilinear')
%           meaning no interpolation, nearest neighbor interpolation and
%           bilinear interpolation, respectively.
if ~exist('interpolation', 'var')
    interpolation = 'none';
end
if ~ismatrix(A)
    A = [A 0 0; 0 A 0; 0 0 1;];
end

% Image size
M = size(I, 1); % height
N = size(I, 2); % width
D = [M, N, 1];  % dimensions

% Transformed dimensions
Dt = D * A;
Mt = floor(Dt(1));
Nt = floor(Dt(2));

% Map coordinates to new values
It = zeros(Mt, Nt);

%% Inverse mapping
% Perform _inverse mapping_ instead of forward mapping. Compute 
% the inverse affine transformation matrix $A^{-1}$. See 
% section 2.6 of (DIP, 42 - Gonzalez, Woods) book, page 102.
for x = 1:Mt
    for y = 1:Nt
        Pt = [x, y, 1];
        P = Pt / A; % original coordinate (same as Pt * inv(A)).
        switch interpolation
            case 'nearest' 
                P = round(Pt / A);
                It(x, y) = I(P(1), P(2));
            otherwise % no interpolation, i.e. 'none'
                if all(mod(P, 1) == 0) % 
                    It(x, y) = I(P(1), P(2));
                else
                    It(x, y) = 0;
                end
                
        end
    end
end

end

