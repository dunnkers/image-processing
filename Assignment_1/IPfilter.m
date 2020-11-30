% Do not use filter, filter2, conv, or conv2
% Spacial filtering of an image
function result = IPfilter(f, kernel)
    [M, N] = size(f); %M = height/#rows, N = width/#columns
    result = zeros(M,N);
    [kernelHeight, kernelWidth] = size(kernel);
    a = (kernelHeight-1)/2;
    b = (kernelWidth-1)/2;
    kernelCenterX = (kernelHeight+1) / 2;
    kernelCenterY = (kernelWidth+1) / 2;
    for x=1:M
        for y=1:N
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