clc;                                  % clear the command window
close all;                            % close open figure windows      

imname = 'wirebondmask';
inputfile = ['input_images/', imname, '.tif'];          
f = imread(inputfile);                  % read input image

% Original image
figure('visible', 'off');
colormap(gray(256));
imagesc(f);
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
imshow(IPdilate(f, Bcross));
saveas(gcf, ['output_plots/', imname, '_Bcross', '_dilated', '.svg']);
% Erode
figure('visible', 'off');
imshow(IPerode(f, Bcross));
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
imshow(IPdilate(f, Bsquare));
saveas(gcf, ['output_plots/', imname, '_Bsquare', '_dilated', '.svg']);
% Erode
figure('visible', 'off');
imshow(IPerode(f, Bsquare));
saveas(gcf, ['output_plots/', imname, '_Bsquare', '_eroded', '.svg']);

%% Big square
Bbigsquare = true(15, 15);
[r, c] = meshgrid(1:15, 1:15);
Bbigsquare(r + c < 7) = 0; % remove North-West corner
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
imshow(IPdilate(f, Bbigsquare));
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_dilated', '.svg']);
% Erode
figure('visible', 'off');
imshow(IPerode(f, Bbigsquare));
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_eroded', '.svg']);

% Compare with Matlab's built-in functions
%% Compare IPdilate to imdilate
figure('visible', 'off');
g = IPdilate(f, Bbigsquare);
imshow(g);
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_IPdilate', '.svg']);
% imdilate
figure('visible', 'off');
g2 = imdilate(f, Bbigsquare);
imshow(g2);
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_imdilate', '.svg']);
% difference
figure('visible', 'off');
imshow(g - g2);
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_dilate', '_diff', '.svg']);

%% Compare IPerode to imerode
figure('visible', 'off');
g = IPerode(f, Bbigsquare);
imshow(g);
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_IPerode', '.svg']);
% imerode
figure('visible', 'off');
g2 = imerode(f, Bbigsquare);
imshow(g2);
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_imerode', '.svg']);
% difference
figure('visible', 'off');
imshow(g - g2);
saveas(gcf, ['output_plots/', imname, '_Bbigsquare', '_erode', '_diff', '.svg']);

%% Erode with 3 different SE's - Figure 9.5 from the book.
% 11x11 square SE
figure('visible', 'off');
imshow(IPerode(f, true(11, 11)));
saveas(gcf, ['output_plots/', imname, '_11x11SE', '_erode', '.svg']);
% 15x15 square SE
figure('visible', 'off');
imshow(IPerode(f, true(15, 15)));
saveas(gcf, ['output_plots/', imname, '_15x15SE', '_erode', '.svg']);
% 45x45 square SE
figure('visible', 'off');
imshow(IPerode(f, true(45, 45)));
saveas(gcf, ['output_plots/', imname, '_45x45SE', '_erode', '.svg']);
