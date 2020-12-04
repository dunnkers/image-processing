clc;
imname = 'circuitboard';
inputfile = ['input_images/', imname,'.tif'];          
f = imread(inputfile);
f = im2double(f);
d = 0.2;
noisyImage = imnoise(f, 'salt & pepper', d);
k = 1;
filteredImage = IPmedian(noisyImage, k);
matlabImage = medfilt2(noisyImage, 'indexed');


figure;
imshow(filteredImage);

figure;
imshow(matlabImage);

figure;
subplot(221);
imshow(f)
title('orginal image')

subplot(222);
imshow(noisyImage)
title('noisy image')

subplot(223);
imshow(filteredImage)
title('IPmedian')

subplot(224);
imshow(matlabImage)
title('medfilt2')


% for c: The big difference is the pixels at the borders of the image.
% both matlab's function and mine give the same result as far as I can
% tell. But it still has black pixels around the corners whereas the image
% in the book does not. This is most likely due to a different handling of
% the edges. Both my function and Matlab's function use zero padding. If
% you use the option 'indexed' in Matlab's function this is solved, since
% it now pads with 1's.

