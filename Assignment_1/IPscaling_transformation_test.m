I = [125 250 0; 200 75 0; 255 255 255;];
factor = 80;
method = 'nearest';
It = IPscaling_transformation(I, factor, method);

f = figure;
subplot(131);
imagesc(I);
axis equal;
axis tight;
title('original')

subplot(132);
colormap(gray(256));
imagesc(It);
axis equal;
axis tight;
title('IPscaling\_transformation')

subplot(133);
colormap(gray(256));
imagesc(imresize(I, factor, method));
axis equal;
axis tight;
title('imresize')

% Write current figure to file
all_file = ['output_plots/', 'matrix_all',...
    '_', method,...
    '_factor=', num2str(factor), '.svg'];
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 0.7 0.15])
saveas(gcf, all_file);

fprintf('\nComplete image has been saved in file %s\n', all_file);
