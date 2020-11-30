clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'cktboard';

inputfile = ['input_images/', imname,'.tif'];          
f=imread(inputfile);                  % read input image
M = size(f,1);
N = size(f,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image upsampling
upsamplingFactor = uint8(4);
g = IPupsample(f, upsamplingFactor);


% Write output to file
outputfile = ['output_images/', imname, ...
    '_upsamplingFactor=' num2str(upsamplingFactor), '.png'];
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
title('UPSAMPLED IMAGE')

% Write current figure to file
all_file = ['output_plots/', imname,'_all','_upsamplingFactor=', ...
       num2str(upsamplingFactor),'.svg'];
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 0.7 0.15])
saveas(gcf,all_file);

fprintf('\nComplete image has been saved in file %s\n', all_file);

