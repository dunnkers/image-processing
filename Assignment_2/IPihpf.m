function H = IPihpf(D0, M, N)
% IPihpf Ideal highpass filter (IHPF) implementation.
%   Input arguments:
%       D0 = cutoff frequency
%       M x N = size
%   Output arguments:
%       H = transfer function

D = IPfreqrectdists(M, N); % Obtain distances to PxQ center

% Ideal highpass filter (ILPF): Eq (4-119)
H = zeros(M*2, N*2);
H(D <= D0) = 0;
H(D > D0) = 1;
end