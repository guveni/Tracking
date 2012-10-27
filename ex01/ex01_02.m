

im = imread('lena.gif');
display('sigma = 1.0') 

sigma = 1;

% a) generate 2d gaussian and do convolution
% sigma = 1: 7.6 seconds
% sigma = 3: 63.2 seconds
gaussian2d = getGaussian2d(sigma);

tic
res1 = convolute(im,gaussian2d,1);
toc


% b) generate 1d gaussians and do two convolutions
% sigma = 1: 12.7 seconds
% sigma = 3: 34.0 seconds
gaussian1dCol = getGaussian1d(sigma);
gaussian1dRow = transpose(gaussian1dCol);

tic
res2 = convolute(im,gaussian1dCol,1);
res2 = convolute(res2,gaussian1dRow,1);
toc

% compute sum of squared differences of the two results:
% only very very small error (about e-22)
display('error between 2d convolution and 2 times 1d convolution:')
error = sum(sum(((res1-res2).^2)))


figure();
imshow(res1,[0 255]);
title('2d filtered');

figure();
imshow(res2,[0 255]);
title('2 times 1d filtered');

input('sigma 1 has finished - press any key');
% ------------------------------ now with sigma = 3

display('sigma = 3.0') 

sigma = 3;

% a) generate 2d gaussian and do convolution
% sigma = 1: 7.6 seconds
% sigma = 3: 63.2 seconds
gaussian2d = getGaussian2d(sigma);

tic
res1 = convolute(im,gaussian2d,1);
toc


% b) generate 1d gaussians and do two convolutions
% sigma = 1: 12.7 seconds
% sigma = 3: 34.0 seconds
gaussian1dCol = getGaussian1d(sigma);
gaussian1dRow = transpose(gaussian1dCol);

tic
res2 = convolute(im,gaussian1dCol,1);
res2 = convolute(res2,gaussian1dRow,1);
toc

% compute sum of squared differences of the two results:
% only very very small error (about e-22)
display('error between 2d convolution and 2 times 1d convolution:')
error = sum(sum(((res1-res2).^2)))


figure();
imshow(res1,[0 255]);
title('2d filtered');

figure();
imshow(res2,[0 255]);
title('2 times 1d filtered');



input('press any key to quit')
close all


