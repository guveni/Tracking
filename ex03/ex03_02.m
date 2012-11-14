img = imread('lena.gif');

resolutionLevels = 5;
s0 = 1.5;
k = 1.2;
alpha = 0.06;
thresholdHigh = 1500;
thresholdLow = 10;

allResults = harrisLaplace(resolutionLevels, img, s0, k, alpha, thresholdHigh, thresholdLow);

figure();
imshow(allResults,[0 1]);