clc;                                  % clear the command window
close all;                            % close open figure windows      


%%%%%%%% Blurry moon example %%%%%%%%
imname = 'blurrymoon';      
showcase(imname, '.tif');

%%%%%%%% Another example image %%%%%%%%
%%% From: https://en.wikipedia.org/wiki/Histogram_equalization
imname = 'HawkesBay';
showcase(imname, '.jpg');

function showcase(imname, imext)
% Normal image and histogram
inputfile = ['input_images/', imname, imext];
I = imread(inputfile);
h = IPhistogram(I);
% Compute equalized image and histogram
[I_eq, h_eq] = IPhisteq(I);

% Make a nice 2x2 plot
figure;
subplot(221);
colormap(gray(256));
imagesc(I);
title([imname, ' image']);
subplot(222);
colormap(gray(256));
imagesc(I_eq);
title(['Histogram-equalized ', imname]);
subplot(223);
bar(h);
title('Histogram');
subplot(224);
bar(h_eq);
title('Equalized histogram');

% Write output to file
outputfile = ['output_images/', imname, ...
    '_histeq', '.png'];
imwrite(I_eq, outputfile);
fprintf('\nFiltered image saved in file %s\n', outputfile);

% Write current figure to file
all_file = ['output_plots/', imname, '_all_histeq', '.svg'];
saveas(gcf, all_file);
fprintf('\nComplete image has been saved in file %s\n', all_file);
end
