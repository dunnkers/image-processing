function H = IPbhpf(D0, n, M, N)
% IPbhpf Butterworth highpass filter (BHPF) implementation.
%   Input arguments:
%       D0 = cutoff frequency
%       n = order
%       M x N = size
%   Output arguments:
%       H = transfer function

D = IPfreqrectdists(M, N); % Obtain distances to PxQ center

% Transfer function of Butterworth highpass filter (BHPF)
H = 1 ./ (1 + (D0 ./ D) .^ (2 * n)); % Eq (4-121)
end