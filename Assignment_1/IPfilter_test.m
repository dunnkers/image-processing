clc;
imname='bubbles';
inputfile = ['input_images/', imname,'.tif'];          
f=imread(inputfile);
f = im2double(f);
kernel = [0 1 0; 1 -4 1; 0 1 0];
filteredImage = IPfilter(f, kernel);

figure;
subplot(131);
imshow(f)
title('orginal image')

subplot(132);
matlabImage = filter2(kernel,f);
imshow(matlabImage)
title('filter2()')

subplot(133);
imshow(filteredImage)
title('IPfilter()')

% Write current figure to file
imwrite(matlabImage, 'output_images/filter_matlab.png');
imwrite(filteredImage, 'output_images/filter_kevin.png');

