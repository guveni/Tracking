img = imread('lena.gif');

img = imresize(img,0.3,'bilinear');

img = double(img);

values =[1 5 10];

% display original
figure();
imshow(img,[0 255]);
title('original image');

% run the function to filter the image 3 times
for i=1:3
    sigma = values(i);
    imgNeu = applyBilateralFilter(img,sigma,sigma);
    figure();
    imshow(imgNeu,[0 255]);
    title( sprintf('After bilateral filter with sigma %d',sigma) );
    
    gaussianMask = fspecial('gaussian',sigma);
    
    imgGaussian = imfilter(img,gaussianMask,'conv');
    figure();
    imshow(imgGaussian,[0 255]);
    title( sprintf('After gaussian filter with sigma %d',sigma) );
end

% results:
% b)
% with sigma = 1 the filter does nothing
% for higher sigma the filter smothes areas of similar color, but preserves
% edges (the higher sigma, the highter the smoothing of the area)
%
% c) 
% normal gaussian smoothes also the edges (bilateral filter preserves edges)
%
% d) 
% you can't.
% you could implement the closeness-term by using normal convolution, but
% not the similarity, because the summand for each pixel also depends on
% the intensitiy of that pixel and also on the intensity of the center
% pixel

input('press any key to finish');
close all;