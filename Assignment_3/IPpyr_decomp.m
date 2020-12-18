function g = IPpyr_decomp(f, J, sigma)
% IPpyr_decomp Laplacian pyramid decomposition
%   Arguments:
%       f: input image
%       J: the number of decomposition levels
%       sigma: standard deviation of the Gaussian filter
f_1 = im2double(f);
[M, N] = size(f_1); % height, width
assert(M == N);

% Store pyramid and differences in cells
f = cell(1, J);
f(1) = mat2cell(f_1, M);
d = cell(1, J - 1);

% Build image pyramid
for j = 2:J
    f_prev = cell2mat(f(j - 1));
    
    % REDUCE
    f_j = imgaussfilt(f_prev, sigma);
    f_j = IPdownsample(f_j, uint8(2));
    
    % EXPAND & difference
    expanded = IPzoom(f_j, uint8(2));
    expanded = imgaussfilt(expanded, sigma);
    d_j = f_prev - expanded;
    
    % Store in cells
    f(j) = mat2cell(f_j, size(f_j, 1));
    d(j - 1) = mat2cell(d_j, size(d_j, 1));
end

% Build output g
D = M * (1/2) .^ (0:J-1);      % compute image dimensions D for all levels
P = sum(D) + 1;                % +1 for Matlab indexing
x = M/2 - D/2 + 1;             % compute `g` x-coordinates
y = cumsum([0, D(1:J-1)]) + 1; % compute `g` y-coordinates

% Insert detail signals `d` and coarsest decomposition level `J` into image
g = ones(P, M);
for j = 1:J
    if (j == J); im = f(j); else; im = d(j); end
    g(y(j):y(j)+D(j)-1, x(j):x(j)+D(j)-1) = cell2mat(im);
end
end