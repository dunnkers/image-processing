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

downsamplingFactor2 = uint8(15);
g2 = IPdownsample(f, downsamplingFactor2);

% Write output to file
outputfile = ['output_images/', imname,...
    '_downsamplingFactor=' num2str(downsamplingFactor), '.png'];
imwrite(g, outputfile);
fprintf('\nFiltered image saved in file %s\n', outputfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot images

% Plot the input image
figure;
subplot(131);
colormap(gray(256));
imagesc(f);
axis equal;
axis tight;
title('INPUT IMAGE')

% Plot the output image
subplot(132);
colormap(gray(256));
imagesc(g);
axis equal;
axis tight;
title('DOWNSAMPLED (x4)')

% Plot the output image
subplot(133);
colormap(gray(256));
imagesc(g2);
axis equal;
axis tight;
title('DOWNSAMPLED (x15)')

% Write current figure to file
all_file = ['output_plots/', imname,'_all',...
    '_downsamplingFactor=', num2str(downsamplingFactor), '.svg'];
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 0.7 0.15])
saveas(gcf,all_file);

fprintf('\nComplete image has been saved in file %s\n', all_file);

