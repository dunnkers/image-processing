function result = IPlaplacian(f, kernel)
    [M, N] = size(f); %M = height/#rows, N = width/#columns
    laplacian = IPfilter(f, kernel); % create laplacian image

    % substract laplacian image from orginal image
    result = zeros(M,N);
    if (all(all(kernel == [0,1,0; 1,-4,1; 0,1,0])) || ...
        all(all(kernel == [1,1,1; 1,-8,1; 1,1,1])))
        c = -1;
    else
        c = 1;
    end
    
    for x=1:M
        for y=1:N
            result(x,y) = f(x,y) + c * laplacian(x,y);
        end
    end
end

