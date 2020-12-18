function g2 = IPpyr_recon(g,J,sigma)
% IPpyr_recon Laplacian pyramid reconstruction
%   Arguments:
%       g: result matrix from IPpyr_decomp
%       J: the number of decomposition levels
%       sigma: standard deviation of the Gaussian filter

    [P, M] = size(g);

    % Extract residuals d and coarsest level image f_J
    D = M * (1/2) .^ (0:J-1);      % compute image dimensions D for all levels
    x = M/2 - D/2 + 1;             % compute `g` x-coordinates
    y = cumsum([0, D(1:J-1)]) + 1; % compute `g` y-coordinates

    d = cell(1, J - 1);
    for j = 1:J
        im = g(y(j):y(j)+D(j)-1, x(j):x(j)+D(j)-1);
        if (j == J); f_j = im; else; d(j) = mat2cell(im, D(j)); end
    end
    
    % >> Kevin's
    M_j = M / (2^(J-1));
    N_start_j = M_j * (2^(J-1) / 2) - 0.5 * M_j;
    f_j_kevin = g(P-M_j:P-1, N_start_j+1:N_start_j+M_j);
    assert(all(all(f_j == f_j_kevin)));
    usedSpace = M_j;

    for j = (J-1):-1:1
        % EXPAND = upsample & Gaussian filter
        f_j = IPzoom(f_j, uint8(2));
        f_j = imgaussfilt(f_j, sigma);
        
        % >> Kevin's
        M_j = M / (2^(j-1));
        N_start_j = M_j * (2^(j-1) / 2) - 0.5 * M_j;
        g_j = g(P-usedSpace-M_j:P-usedSpace-1, N_start_j+1:N_start_j+M_j);
        usedSpace = usedSpace + M_j;
        assert(all(all(g_j == cell2mat(d(j)))));
        
        % Add previous d to expanded image
        f_j = f_j + cell2mat(d(j));
    end
    g2 = f_j;
end