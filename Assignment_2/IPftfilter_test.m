clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'characters';
inputfile = ['input_images/', imname,'.tif'];          
f = imread(inputfile);                  % read input image

figure;
% Original image
subplot(131);
imshow(f);
axis equal;
axis tight;
title({'Original `characters` image', ' '});

% Butterworth filter using D0 = 60
subplot(132);
[M, N] = size(f); % height, width
D0 = 60;
n = 2;
H = IPbhpf(D0, n, M, N);
I = IPftfilter(f, H);
imshow(I);
axis equal;
axis tight;
title({'BHPF filtered image', '(D0=60, n=2)'});

% Butterworth filter using D0 = 160
subplot(133);
D0 = 160;
H = IPbhpf(D0, n, M, N);
I = IPftfilter(f, H);
imshow(I);
axis equal;
axis tight;
title({'BHPF filtered image', '(D0=160, n=2)'});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Write current figure to file
all_file = ['output_plots/', imname,'_all','_bhpf', '.svg'];
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 1.75 0.40])
saveas(gcf, all_file);
fprintf('\nComplete image has been saved in file %s\n', all_file);

