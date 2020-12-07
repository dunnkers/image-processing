% Function that performs a general image filter
% It takes the orginal image and a chosen kernel as input
% It outputs the enhanced image
function result = IPfilter(f, kernel)
    [M, N] = size(f); %M = height, N = width
    result = zeros(M,N);
    [kernelHeight, kernelWidth] = size(kernel);
    a = (kernelHeight-1)/2;
    b = (kernelWidth-1)/2;
    kernelCenterX = (kernelHeight+1) / 2;
    kernelCenterY = (kernelWidth+1) / 2;
    % loop over all the pixels in the image
    for x=1:M
        for y=1:N
            % loop over the kernel size
            for s=-a:a
                for t=-b:b
                    if (x+s < 1 || y+t < 1 || x+s > M || y+t > N)
                        % skip anything outside the orginal image.
                        % has the same effect as zero padding.
                        continue;
                    end
                    result(x,y) = result(x,y) + kernel(kernelCenterX+s, ...
                        kernelCenterY+t) * f(x+s, y+t);
                end
            end
        end
    end
end