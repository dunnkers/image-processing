% Function that performs the laplacian enhancement technique
% It takes the orginal image and a chosen kernel as input
% It outputs the enhanced image
function result = IPlaplacian(f, kernel)
    laplacian = IPfilter(f, kernel); % create laplacian image

    % substract or add laplacian image from orginal image,
    % depending on kernel used. See book Figure 3.45, section 3.6.
    if (isequal(kernel, [0,1,0; 1,-4,1; 0,1,0]) || ...
        isequal(kernel, [1,1,1; 1,-8,1; 1,1,1]))
        c = -1;
    else
        c = 1;
    end
    
    result = f + c * laplacian; % add filter to image
end

