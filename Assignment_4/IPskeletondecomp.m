function sum_Sk = IPskeletondecomp(I, B)
    % (A erode kB) - ((A erode kB) dilate B)
    assert(islogical(I));
    assert(islogical(B));
    
    % Opening
    eroded_I = IPerode(I, B);
    opened_I = IPdilate(eroded_I, B);
    
    Sk = logical(I - opened_I);
%     figure;
%     imshow(Sk)
    
    eroded_A = IPerode(I, B);
    
    % basecase: figure is empty after erosion
    if (sum(eroded_A, 'all') == 0)
        sum_Sk = eroded_A; % empty figure
        return
    else
        sum_Sk = logical(Sk + IPskeletondecomp(eroded_A, B));
%         figure;
%         imshow(sum_Sk)
    end
end




