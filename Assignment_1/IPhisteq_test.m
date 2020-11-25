clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'blurrymoon';

inputfile = [imname,'.tif'];          
f=imread(inputfile);                  % read input image
M = size(f,1);
N = size(f,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h = IPhistogram(f);
h_eq = IPhisteq(h);
figure;
bar(h_eq);
title('IPhisteq()')

% Write current figure to file
all_file = [imname,'_histeq', '.png'];
saveas(gcf, all_file);
fprintf('\nComplete image has been saved in file %s\n', all_file);

