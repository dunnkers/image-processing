clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'cktboard';

inputfile = ['input_images/', imname,'.tif'];          
f=imread(inputfile);                  % read input image
M = size(f,1);
N = size(f,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image zooming
zoomFactor = uint8(4);
g = IPzoom(f, zoomFactor);

% Downsample, then zoom back again
g_ds = IPdownsample(f, zoomFactor);
g_ = IPzoom(g_ds, zoomFactor);

% Write output to file
outputfile = ['output_images/', imname, ...
    '_zoomFactor=' num2str(zoomFactor), '.png'];
imwrite(g, outputfile);
fprintf('\nFiltered image saved in file %s\n', outputfile);

outputfile = ['output_images/', imname, ...
    '_reconstruction=' num2str(zoomFactor), '.png'];
imwrite(g_, outputfile);
fprintf('\nReconstructed image saved in file %s\n', outputfile);

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
title('ZOOMED IMAGE')

% Write current figure to file
all_file = ['output_plots/', imname,'_all', ...
    '_zoomFactor=',num2str(zoomFactor),'.svg'];
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 0.7 0.15])
saveas(gcf,all_file);

%%% Plot reconstructed image
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
imagesc(g_);
axis equal;
axis tight;
title('RECONSTRUCTED IMAGE')

% Write current figure to file
all_file = ['output_plots/', imname,'_all',...
    '_reconstruction=',num2str(zoomFactor),'.svg'];
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 0.7 0.15])
saveas(gcf,all_file);

fprintf('\nComplete image has been saved in file %s\n', all_file);

