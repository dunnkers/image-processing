% IPscaling_transformation([125 250; 250 75;], 2, 'bilinear');

I = imread('input_images/cktboard.tif');
factor = 2;
method = 'nearest';
It = IPscaling_transformation(I, factor, method);
subplot(121);
colormap(gray(256));
imagesc(It);
axis equal;
axis tight;

title('IPscaling\_transformation')
subplot(122);
colormap(gray(256));
imagesc(imresize(I, factor, method));
axis equal;
axis tight;
title('imresize')
