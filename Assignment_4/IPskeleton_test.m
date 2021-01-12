clc;                                  % clear the command window
close all;                            % close open figure windows    
clear;                                % clear workspace

imname = 'nutsbolts';
inputfile = ['input_images/', imname, '.tif'];          
f = imread(inputfile);                  % read input image
% K = 7 for our input

B_square = logical([1 1 1; 1 1 1; 1 1 1]);

% f = logical([1 0 0 0 0; 0 1 1 0 0; 0 1 1 0 0; 0 1 1 1 0;
%     0 1 1 1 0; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1;]);

% f = logical([   0 0 0 0 0 0 0;
%                 0 1 0 0 0 0 0;
%                 0 0 1 1 0 0 0;
%                 0 0 1 1 0 0 0;
%                 0 0 1 1 1 0 0;
%                 0 0 1 1 1 0 0;
%                 0 1 1 1 1 1 0;
%                 0 1 1 1 1 1 0;
%                 0 1 1 1 1 1 0;
%                 0 1 1 1 1 1 0;
%                 0 1 1 1 1 1 0;
%                 0 0 0 0 0 0 0;]);

skeleton = IPskeletondecomp(f, B_square);
reconstruction = IPskeletonrecon(skeleton, B_square);

% Show that they are in fact the same
difference = sum(imabsdiff(f, reconstruction), 'all');

% Show 
figure;
subplot(221);
imshow(f)
title("input image");
subplot(222);
imshow(reconstruction)
title("reconstruction");
subplot(223);
imshow(skeleton)
title("IPskeletondecomp");
subplot(224);
imshow(f-reconstruction)
title("difference=" + difference);




