clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'blurrymoon';

inputfile = ['input_images/', imname,'.tif'];          
f=imread(inputfile);                  % read input image
M = size(f,1);
N = size(f,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = IPhistogram(f, 2^8/4);
figure;
subplot(121);
h_ref = histogram(f, 2^8/4);
title('histogram()')
subplot(122);
bar(h);
title('IPhistogram()')

% Write current figure to file
all_file = ['output_plots/', imname,'_all','_histograms', '.svg'];
saveas(gcf, all_file);
fprintf('\nComplete image has been saved in file %s\n', all_file);

