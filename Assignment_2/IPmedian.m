function result = IPmedian(f, k)
    [M, N] = size(f); %M = height, N = width
    windowSize = 2*k+1;
    result = zeros(M,N);
    % loop over all the pixels in the image
    for x=1:M
        for y=1:N
            set = zeros(windowSize);
            % loop over the window size
            for r=-k:k
                for c=-k:k
                    if (x+r < 1 || y+c < 1 || x+r > M || y+c > N)
                        % fixed one padding
                        set(k+1+r, k+1+c) = double(1);
                        continue;
                    end
                    set(k+1+r, k+1+c) = f(x+r, y+c);
                end
            end
            % take the median of the pixels inside the window
            result(x,y) = median(set, [1,2]);
        end
    end
end

