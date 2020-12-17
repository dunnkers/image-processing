function g2 = IPpyr_recon(g,J,sigma)
% IPpyr_recon Laplacian pyramid reconstruction
%   Arguments:
%       g: result matrix from IPpyr_decomp
%       J: the number of decomposition levels
%       sigma: standard deviation of the Gaussian filter

    [P, M] = size(g);
    
    % extract coarsest level image
    M_j = M / (2^(J-1));
    N_start_j = M_j * (2^(J-1) / 2) - 0.5 * M_j;
    f_j = g(P-M_j+1:P, N_start_j+1:N_start_j+M_j);
    usedSpace = M_j;
    
    for j = (J-1):-1:1
        % EXPAND = upsample & Gaussian filter
        f_j = IPzoom(f_j, uint8(2));
        f_j = imgaussfilt(f_j, sigma);
        
        % extract previous d
        M_j = M / (2^(j-1));
        N_start_j = M_j * (2^(j-1) / 2) - 0.5 * M_j;
        g_j = g(P-usedSpace-M_j+1:P-usedSpace, N_start_j+1:N_start_j+M_j);
        usedSpace = usedSpace + M_j;
        
        % add previous d to expanded image
        f_j = f_j + g_j;
    end
    g2 = f_j;
end