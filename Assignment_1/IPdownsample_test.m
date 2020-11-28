clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'cktboard';

inputfile = ['input_images/', imname,'.tif'];          
f=imread(inputfile);                  % read input image
M = size(f,1);
N = size(f,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image downsampling
downsamplingFactor = uint8(4);
g = IPdownsample(f, downsamplingFactor);


% Write output to file
outputfile = ['output_images/', imname,...
    '_downsamplingFactor=' num2str(downsamplingFactor), '.png'];
imwrite(g, outputfile);
fprintf('\nFiltered image saved in file %s\n', outputfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot images

% Plot the input image
figure;
subplot(121);
colormap(gray(256));
imagesc(f);
axis equal;
axis tight;
title('INPUT IMAGE')

% Plot the output image
subplot(122);
colormap(gray(256));
imagesc(g);
axis equal;
axis tight;
title('DOWNSAMPLED IMAGE')

% Write current figure to file
all_file = ['output_plots/', imname,'_all',...
    '_downsamplingFactor=', num2str(downsamplingFactor), '.svg'];
saveas(gcf,all_file);

fprintf('\nComplete image has been saved in file %s\n', all_file);

