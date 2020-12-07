function D = IPfreqrectdists(M, N)
% IPfreqrectdists Computes distances between points (u, v) in the frequency
% domain and the center of the P x Q frequency rectangle, i.e. Eq (4-112).
%   Input arguments:
%       M x N = size
%   Output arguments:
%       D = distance function

P = 2*M; % Eq (4-102)
Q = 2*N; % Eq (4-103)
u = 0:(P - 1); 
v = 0:(Q - 1);

% Make coordinate grid
[U, V] = meshgrid(u, v); 

% Distance between a point (u, v) in the frequency domain and the center
% of the P x Q frequency rectangle 
D = sqrt((U - P/2).^2 + (V - Q/2).^2); % Eq (4-112)
end