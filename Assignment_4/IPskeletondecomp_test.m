clc;                                  % clear the command window
close all;                            % close open figure windows    
clear;                                % clear workspace

imname = 'nutsbolts';
inputfile = ['input_images/', imname, '.tif'];          
f = imread(inputfile);                  % read input image
class(f)
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

whos skeleton
whos matlab_skeleton

sum(imabsdiff(skeleton, matlab_skeleton), 'all')

figure;
subplot(131);
imshow(f)
title("input image");
subplot(132);
imshow(skeleton)
title("IPskeletondecomp");
subplot(133);
imshow(matlab_skeleton)
title("matlab\_skeleton");





