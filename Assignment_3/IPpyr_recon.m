function g2 = IPpyr_recon(g,J,sigma)
% IPpyr_recon Laplacian pyramid reconstruction
%   Arguments:
%       g: result matrix from IPpyr_decomp
%       J: the number of decomposition levels
%       sigma: standard deviation of the Gaussian filter

    [P, M] = size(g);
    
    % calculate the coordinates needed for each level
    D = M * (1/2) .^ (0:J-1);      % compute image dimensions D for all levels
    P = sum(D) + 1;                % +1 for Matlab indexing
    x = M/2 - D/2 + 1;             % compute `g` x-coordinates
    y = cumsum([0, D(1:J-1)]) + 1; % compute `g` y-coordinates
    
    % extract coarsest level image
    f_j = g(y(J):y(J)+D(J)-1, x(J):x(J)+D(J)-1);
    
    for j = (J-1):-1:1
        % EXPAND = upsample & Gaussian filter
        f_j = IPzoom(f_j, uint8(2));
        f_j = imgaussfilt(f_j, sigma);
        
        % extract previous d
        g_j = g(y(j):y(j)+D(j)-1, x(j):x(j)+D(j)-1);
        
        % add previous d to expanded image
        f_j = f_j + g_j;
    end
    g2 = f_j;
end