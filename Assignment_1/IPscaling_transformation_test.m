% IPscaling_transformation([125 250; 250 75;], 2, 'bilinear');

I = imread('input_images/cktboard.tif');
% I = [125 250; 200 75;];
factor = 1/2;
method = 'nearest';
It = IPscaling_transformation(I, factor, method);

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
