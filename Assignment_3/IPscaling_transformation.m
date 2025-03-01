function It = IPscaling_transformation(I, A, interpolation)
% IPscaling_transformation Computes an image scaling operation
% using an affine transformation matrix.
% Arguments:
%       I: Input image
%       A: Affine transformation matrix [3x3] of form 
%           [cx 0 0; 0 cy 0; 0 0 1;] or a scalar value, then cx=cy.
%       interpolation: interpolation method. See IPinterpolate.m
if isnumeric(A)
    A = [A 0 0; 0 A 0; 0 0 1;];
end
if ~exist('interpolation', 'var')
   interpolation = 'none';
end
I = im2double(I);

% Image size
[M, N] = size(I); % height, width
D = [M, N, 1];  % dimensions

% Transformed dimensions
Dt = D * A;
Mt = round(Dt(1));
Nt = round(Dt(2));

% Map coordinates to new values
It = zeros(Mt, Nt);

%% Inverse mapping
% Perform _inverse mapping_ instead of forward mapping. Compute 
% the inverse affine transformation matrix $A^{-1}$. See 
% section 2.6 of (DIP, 42 - Gonzalez, Woods) book, page 102.
for y = 1:Mt
    for x = 1:Nt
        Pt = [x, y, 1];
        P = Pt / A; % original coordinate (same as Pt * inv(A)).
        offset = diag(0.5 * (1 - inv(A)))'; % inverse mapping centering offset
        It(y, x) = IPinterpolate(I, P, offset, interpolation);
    end
end

end

