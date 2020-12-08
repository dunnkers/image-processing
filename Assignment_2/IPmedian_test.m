clc;
imname = 'circuitboard';
inputfile = ['input_images/', imname,'.tif'];          
f = imread(inputfile);
f = im2double(f);
d = 0.2;

% create salt-and-pepper noisy image
noisyImage = imnoise(f, 'salt & pepper', d);

% apply 3x3 mask in IPmedian filter
k = 1;
filteredImageZeroPad = IPmedianZeroPad(noisyImage, k);
filteredImage = IPmedian(noisyImage, k);

% verify the result against Matlab's own function
matlabImage = medfilt2(noisyImage, 'indexed');

% do 2 more passes (for a total of 3 passes)
multipassFilteredImage = IPmedian(IPmedian(filteredImage, k),k);

figure;
imshow(filteredImageZeroPad);

figure;
subplot(221);
imshow(f)
title('original image')

subplot(222);
imshow(noisyImage)
title('noisy image')

subplot(223);
imshow(filteredImageZeroPad)
title('IPmedian (zero-padding)')

subplot(224);
imshow(filteredImage)
title('IPmedian (one-padding)')

% Write current figure to file
set(gcf, 'PaperUnits', 'normalized')
saveas(gcf, 'output_plots/IPmedian_all.svg');

figure;
imshow(multipassFilteredImage)
title('IPmedian (3 passes)')

imwrite(multipassFilteredImage, 'output_plots/multipassFilteredImage.png');


