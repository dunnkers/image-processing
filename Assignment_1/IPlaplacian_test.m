clc;
imname='bubbles';
inputfile = ['input_images/', imname,'.tif'];          
f=imread(inputfile);
f = im2double(f);
kernel = [0,1,0; 1,-4,1; 0,1,0];
laplacian = IPfilter(f, kernel);
result = IPlaplacian(f, kernel);

figure;
subplot(131);
imshow(f)
title('orginal image')

subplot(132);
imshow(result)
title('Laplacian enhancement')

subplot(133);
imshow(laplacian)
title('laplacian filter')

% Write current figure to file
imwrite(result, 'output_images/laplacian_result_kernelA.png');
imwrite(laplacian, 'output_images/laplacian_filter_kernelA.png');

kernel = [1,1,1; 1,-8,1; 1,1,1];
laplacian = IPfilter(f, kernel);
result = IPlaplacian(f, kernel);

figure;
subplot(131);
imshow(f)
title('orginal image')

subplot(132);
imshow(result)
title('Laplacian enhancement')

subplot(133);
imshow(laplacian)
title('laplacian filter')

% Write current figure to file
imwrite(result, 'output_images/laplacian_result_kernelB.png');
imwrite(laplacian, 'output_images/laplacian_filter_kernelB.png');
