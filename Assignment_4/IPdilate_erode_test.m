clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'wirebondmask';
inputfile = ['input_images/', imname, '.tif'];          
f = imread(inputfile);                  % read input image

% Original image
figure('visible', 'off');
colormap(gray(256));
imagesc(f);
title({'Original `wirebondmask` image', ' '});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write current figure to file
all_file = ['output_plots/', imname,'_original','.svg'];
saveas(gcf, all_file);
fprintf('\nComplete image has been saved in file %s\n', all_file);

% Show Morphological operations per Structuring Element
%% Cross
Bcross = logical([0 1 0; 1 1 1; 0 1 0]);
figure('visible', 'off');
colormap(gray(256));
imagesc(Bcross);
xticks(unique(round(get(gca, 'xTick')))); % only whole value tick labels
yticks(unique(round(get(gca, 'yTick')))); % only whole value tick labels
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 0.25 0.15])
saveas(gcf, ['output_plots/', 'Bcross', '.svg']);
% Dilate
figure('visible', 'off');
g = IPdilate(f, Bcross);
colormap(gray(256));
imshow(g);
saveas(gcf, ['output_plots/', imname, '_Bcross', '_dilated', '.svg']);
% Erode
figure('visible', 'off');
g = IPerode(f, Bcross);
colormap(gray(256));
imshow(g);
saveas(gcf, ['output_plots/', imname, '_Bcross', '_eroded', '.svg']);

%% Square
Bsquare = true(3, 3);
figure('visible', 'off');
colormap(gray(256));
imagesc(Bsquare);
xticks(unique(round(get(gca, 'xTick')))); % only whole value tick labels
yticks(unique(round(get(gca, 'yTick')))); % only whole value tick labels
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 0.25 0.15])
saveas(gcf, ['output_plots/', 'Bsquare', '.svg']);
% Dilate
figure('visible', 'off');
g = IPdilate(f, Bsquare);
colormap(gray(256));
imshow(g);
saveas(gcf, ['output_plots/', imname, '_Bsquare', '_dilated', '.svg']);
% Erode
figure('visible', 'off');
g = IPerode(f, Bsquare);
colormap(gray(256));
imshow(g);
saveas(gcf, ['output_plots/', imname, '_Bsquare', '_eroded', '.svg']);

%% Big square
Bbigsquare = true(15, 15);
figure('visible', 'off');
colormap(gray(256));
imagesc(Bbigsquare);
xticks(unique(round(get(gca, 'xTick')))); % only whole value tick labels
yticks(unique(round(get(gca, 'yTick')))); % only whole value tick labels
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 0.25 0.15])
saveas(gcf, ['output_plots/', 'Bbigsquare', '.svg']);
% Dilate
figure('visible', 'off');
g = IPdilate(f, Bbigsquare);
colormap(gray(256));
imshow(g);
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_dilated', '.svg']);
% Erode
figure('visible', 'off');
g = IPerode(f, Bbigsquare);
colormap(gray(256));
imshow(g);
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_eroded', '.svg']);

% Compare with Matlab's built-in functions
%% Compare to imdilate
figure;
subplot(131);
g = IPdilate(f, Bbigsquare);
colormap(gray(256));
imshow(g);
axis equal;
axis tight;
title('IPdilate');
subplot(132);
g2 = imdilate(f, Bbigsquare);
colormap(gray(256));
imshow(g2);
axis equal;
axis tight;
title('imdilate');
subplot(133);
colormap(gray(256));
imshow(g - g2);
axis equal;
axis tight;
title('diff');
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 1.00 0.2])
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_eroded', '_all', '.svg']);
%% Compare to imerode
figure;
subplot(131);
g = IPerode(f, Bbigsquare);
colormap(gray(256));
imshow(g);
axis equal;
axis tight;
title('IPerode');
subplot(132);
g2 = imerode(f, Bbigsquare);
colormap(gray(256));
imshow(g2);
axis equal;
axis tight;
title('imerode');
subplot(133);
colormap(gray(256));
imshow(g - g2);
axis equal;
axis tight;
title('diff');
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 1.00 0.2])
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_dilated', '_all', '.svg']);
%% Erode with 3 different SE's - Figure 9.5 from the book.
figure;
subplot(221);
colormap(gray(256));
imshow(f);
axis equal;
axis tight;
title('original image');
subplot(222);
colormap(gray(256));
imshow(IPerode(f, true(11, 11)));
axis equal;
axis tight;
title('11x11 square SE');
subplot(223);
colormap(gray(256));
imshow(IPerode(f, true(15, 15)));
axis equal;
axis tight;
title('15x15 square SE');
subplot(224);
colormap(gray(256));
imshow(IPerode(f, true(45, 45)));
axis equal;
axis tight;
title('45x45 square SE');
saveas(gcf, ['output_plots/', imname, '_variousse', '_eroded', '_all', '.svg']);