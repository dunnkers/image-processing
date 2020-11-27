clc;
imname='bubbles';
inputfile = ['input_images/', imname,'.tif'];          
f=imread(inputfile);
% kernel = [1 2 1; 0 0 0; -1 -2 -1];
kernel = [0 1 0; 1 -4 1; 0 1 0];
filteredImage = IPfilter(f, kernel);
figure;
subplot(221);
matlabImage = filter2(kernel,f);
imshow(matlabImage)
subplot(222);
imshow(filteredImage)
subplot(223);
imshow(f)