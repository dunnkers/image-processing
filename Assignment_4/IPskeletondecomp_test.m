clc;                                  % clear the command window
close all;                            % close open figure windows    
clear;                                % clear workspace

imname = 'nutsbolts';
inputfile = ['input_images/', imname, '.tif'];          
f = imread(inputfile);                  % read input image
% K = 7 for our input

B_square = logical([1 1 1; 1 1 1; 1 1 1]);

% k = 0;
% eroded_A = IPerode(f, B_square);
% while (sum(eroded_A, 'all'))
%     k = k + 1;
%     eroded_A = IPerode(eroded_A, B_square);
% end
% k

skeleton = IPskeletondecomp(f, B_square);

% Matlab's function to compare
matlab_skeleton = bwskel(f);
matlab_skeleton2 = bwmorph(f,'skel',7);

figure;
subplot(221);
imshow(f)
title("input image");
subplot(222);
imshow(skeleton)
title("IPskeletondecomp");
subplot(223);
imshow(matlab_skeleton)
title("matlab\_skeleton");
subplot(224);
imshow(matlab_skeleton2)




