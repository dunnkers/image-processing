function sum_Sk = IPskeletondecomp(A, B)
    % (A erode kB) - ((A erode kB) dilate B)
    assert(islogical(A));
    assert(islogical(B));
    
    % basecase: figure is empty after erosion
    eroded_A = IPerode(A, B);
    if (sum(eroded_A, 'all') == 0)
        sum_Sk = eroded_A; % empty figure
        return
    end
    
    % Opening
    opened_A = IPdilate(eroded_A, B);
    
    Sk = logical(A - opened_A); % input - opened input
    
    % next recursion will start with the eroded input of this recursion
    next_Sk = IPskeletondecomp(eroded_A, B);
    next_Sk(next_Sk ~= 0) = next_Sk(next_Sk~=0) + 1;
    sum_Sk = Sk + next_Sk;
end




