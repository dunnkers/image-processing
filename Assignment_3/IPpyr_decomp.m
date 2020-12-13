function g = IPpyr_decomp(f, J, sigma)
% IPpyr_decomp Laplacian pyramid decomposition
%   Arguments:
%       f: input image
%       J: the number
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
heights = M * (1/2) .^ (0:J-1);
P = sum(heights);
g = ones(P, M);
for j = 1:J-1
    d_j = cell2mat(d(j));
    w = size(d_j, 1);
    x = M/2 - w/2 + 1;
    y = sum(heights(1:j-1)) + 1;
    g(y:y+w-1, x:x+w-1)=d_j;
end
f_J = cell2mat(f(J));
w = size(f_J, 1);
x = M/2 - w/2 + 1;
y = sum(heights(1:J-1));
g(y:y+w-1, x:x+w-1)=f_J;
end

