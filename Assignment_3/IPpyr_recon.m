function g2 = IPpyr_recon(g,J,sigma)
% IPpyr_recon Laplacian pyramid reconstruction
%   Arguments:
%       g: result matrix from IPpyr_decomp
%       J: the number of decomposition levels
%       sigma: standard deviation of the Gaussian filter

    [P, M] = size(g);

    % Extract residuals d and coarsest level image f_J
    heights = M * (1/2) .^ (0:J-1); % compute image heights for all levels
    d = cell(1, J - 1);
    for j = 1:J
        w = heights(j);
        x = M/2 - w/2 + 1;
        y = sum(heights(1:j-1)) + 1;
        im = g(y:y+w-1, x:x+w-1);
        if (j == J); f_j = im; else; d(j) = mat2cell(im, w); end
    end

    for j = (J-1):-1:1
        % EXPAND = upsample & Gaussian filter
        f_j = IPzoom(f_j, uint8(2));
        f_j = imgaussfilt(f_j, sigma);
        
        % Add previous d to expanded image
        f_j = f_j + cell2mat(d(j));
    end
    g2 = f_j;
end