img = imread('lena.gif');

 img = imread('harris.jpg');
 img = rgb2gray(img);

 img = double(img);
 
resolutionLevels = 5;
s0 = 1.5;
k = 1.2;
alpha = 0.06;
thresholdHarris = 1500;
thresholdLaplace = 10;

allResults = harrisLaplace(resolutionLevels, img, s0, k, alpha, thresholdHarris, thresholdLaplace);

figure();
imshow(allResults,[0 5]);