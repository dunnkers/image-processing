% IPskeletonrecon Reconstructs a binary image from a skeleton.
%   Arguments:
%       skeleton: skeleton image. Must use the encoding from the
%       assignment and thus be of a type that allows for numbers > 1.
%       B: structuring element (SE). Must have odd dimensions and also be 
%       binary, i.e. have logical values. Its origin is automatically set 
%       at its centerpoint.
%   Returns: reconstructed image
function sum_Sk_recon = IPskeletonrecon(skeleton, B)
    assert(islogical(B));

    % Extract part from skeleton where values are 1
    Sk_recon = zeros(size(skeleton));
    Sk_recon(skeleton==1) = 1;
    Sk_recon = logical(Sk_recon);
    
    % Decrease all non-zero values by 1
    skeleton(skeleton~=0) = skeleton(skeleton~=0) - 1;
    
    % Base case: all skeletons have been processed
    if (sum(skeleton, 'all') == 0)
        sum_Sk_recon = Sk_recon;
        return
    end
    
    % Dilate the skeletons for all values of k
    k = max(skeleton, [], 'all');
    next_skel = zeros(size(skeleton));
    for i=1:k
        skel_k = zeros(size(skeleton));
        skel_k(skeleton==i) = 1;
        dilated_skel_k = IPdilate(logical(skel_k), B);
        next_skel(dilated_skel_k==1) = i;
    end
    
    % Recursively call the next dilation step
    sum_Sk_recon = logical(Sk_recon + IPskeletonrecon(next_skel, B));
end