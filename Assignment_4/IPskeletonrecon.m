function sum_Sk_recon = IPskeletonrecon(skeleton, B)
    
    Sk_recon = zeros(size(skeleton));
    Sk_recon(skeleton==1) = 1;
    Sk_recon = logical(Sk_recon);
    
    skeleton(skeleton~=0) = skeleton(skeleton~=0) - 1;
    
    % Base case: all skeletons have been processed
    if (sum(skeleton, 'all') == 0)
        sum_Sk_recon = Sk_recon;
        return
    end
    
    % dilate for all values
    k = max(skeleton, [], 'all');
    next_skel = zeros(size(skeleton));
    for i=1:k
        skel_k = zeros(size(skeleton));
        skel_k(skeleton==i) = 1;
        dilated_skel_k = IPdilate(logical(skel_k), B);
        next_skel(dilated_skel_k==1) = i;
    end
    
    sum_Sk_recon = logical(Sk_recon + IPskeletonrecon(next_skel, B));
end