clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'cktboard';

inputfile = [imname,'.tif'];          
f=imread(inputfile);                  % read input image
M = size(f,1);
N = size(f,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image downsampling
shrinkFactor = 4;
g = IPdownsample(f, shrinkFactor);


% Write output to file
outputfile = [imname, '_shrinkFactor=' num2str(shrinkFactor), '.png'];
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
title('DOWNSCALED IMAGE')

% Write current figure to file
all_file = [imname,'_all','_shrinkFactor=',num2str(shrinkFactor),'.png'];
saveas(gcf,all_file);

fprintf('\nComplete image has been saved in file %s\n', all_file);

