im = imread('lena.gif');

mask = ones(5);
treatment = 1;

tic
result_image = convolute(im,mask,treatment);
toc

tic
mask = mask/sum(mask(:));
im2=imfilter(im,mask,'conv');
toc

subplot(2,2,1); 
imshow(im,[0,255]);
title('original');

subplot(2,2,2); 
imshow(result_image,[0,255]); 
title('our convolution');


subplot(2,2,4); 
imshow(im2,[0,255]); 
title('matlab convolution');


input('END of Exercise') 
close all

