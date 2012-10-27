% exercise 2 part 1

filterSize = 3;

img = imread('lena.gif');

img_saltPepper = addSaltPepperNoise(img,10);
img_gaussian = addGaussianNoise(img,15);

img_median_ori = applyMedianFilter(img,filterSize);
img_median_saltPepper = applyMedianFilter(img_saltPepper,filterSize);
img_median_gaussian = applyMedianFilter(img_gaussianNoise,filterSize);

filter = fspecial('gaussian',filterSize,1);

img_gaussianFiltered_ori = imfilter(img,filter,'conv');
img_gaussianFiltered_saltPepper = imfilter(img_saltPepper,filter,'conv');
img_gaussianFiltered_gaussian = imfilter(img_gaussian,filter,'conv');

subplot(3,3,1); 
imshow(img,[0,255]);
title('original image');

subplot(3,3,2); 
imshow(img_saltPepper,[0,255]); 
title('salt and pepper noise');

subplot(3,3,3); 
imshow(img_gaussian,[0,255]); 
title('gaussian noise');

subplot(3,3,4); 
imshow(img_median_ori,[0,255]); 
title('median: salt and pepper');

subplot(3,3,5); 
imshow(img_median_saltPepper,[0,255]); 
title('median: salt and pepper');

subplot(3,3,6); 
imshow(img_median_gaussian,[0,255]); 
title('median: gaussian noise');

subplot(3,3,7); 
imshow(img_gaussianFiltered_ori,[0,255]); 
title('gaussian-filter: salt and pepper');

subplot(3,3,8); 
imshow(img_gaussianFiltered_saltPepper,[0,255]); 
title('gaussian-filter: salt and pepper');

subplot(3,3,9); 
imshow(img_gaussianFiltered_gaussian,[0,255]); 
title('gaussian-filter: gaussian noise');


figure()
imshow(img_gaussianNoise,[0,255]); 


% Result:
% Gaussian-Filter is better for Gaussian-Noise
% Median-Filter is better for Salt and Pepper Noise


input('END of Exercise - Press any key') 
close all


