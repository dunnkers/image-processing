function sum_Sk = IPskeletondecomp(A, B)
    % (A erode k*B) - ((A erode k*B) dilate B)
    assert(islogical(A));
    assert(islogical(B));

    % Opening of input
    eroded_A = IPerode(A, B);
    opened_A = IPdilate(eroded_A, B);
    
    % Sk = input - opened input
    % (for all k>0 cases the input has been eroded in the previous
    % itteration of the recursion)
    Sk = A - opened_A;
    
%     figure;
%     subplot(221);
%     imshow(A)
%     title("A");
%     subplot(222);
%     imshow(opened_A)
%     title("opened_A");
%     subplot(223);
%     imshow(Sk)
%     title("Sk");
%     subplot(224);
%     imshow(eroded_A)
%     title("eroded_A");
    
    % Basecase: figure is empty after erosion
    if (sum(eroded_A, 'all') == 0)
        sum_Sk = Sk;
        return
    end
    
    % The next recursion will start with the eroded input of this recursion
    next_Sk = IPskeletondecomp(eroded_A, B);
    next_Sk(next_Sk~=0) = next_Sk(next_Sk~=0) + 1;
    sum_Sk = Sk + next_Sk;
end




