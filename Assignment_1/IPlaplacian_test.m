clc;
imname='bubbles';
inputfile = ['input_images/', imname,'.tif'];          
f=imread(inputfile);
f = im2double(f);
% f = cast(f, 'double');
kernel = [0,1,0; 1,-4,1; 0,1,0];
% kernel = [1,1,1; 1,-8,1; 1,1,1];
laplacian = IPfilter(f, kernel);
result = IPlaplacian(f, kernel);


figure;
subplot(131);
imshow(f)
subplot(132);
imshow(result)
subplot(133);
imshow(laplacian)
