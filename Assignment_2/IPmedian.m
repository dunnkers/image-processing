function result = IPmedian(f, k)
    [M, N] = size(f); %M = height, N = width
    windowSize = 2*k+1;
    result = zeros(M,N);
    % loop over all the pixels in the image
    for x=1:M
        for y=1:N
            set = zeros(windowSize);
            % loop over the window size
            for s=-k:k
                for t=-k:k
                    if (x+s < 1 || y+t < 1 || x+s > M || y+t > N)
                        % initial zero padding
                        % set(k+1+s, k+1+t) = double(0);
                        
                        % fixed one padding
                        set(k+1+s, k+1+t) = double(1);
                        continue;
                    end
                    set(k+1+s, k+1+t) = f(x+s, y+t);
                end
            end
            % take the median of the pixels inside the window
            result(x,y) = median(set, [1,2]);
        end
    end
end

