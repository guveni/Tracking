
harrisPointsFileName = 'harrisPoints.model';
samplePointsFileName = 'samplePoints.model';
histogramsFileName = 'histogram.model';

img1 = double(rgb2gray(imread('imagesequence/img1.ppm'))) ;
img2 = double(rgb2gray(imread('imagesequence/img2.ppm'))) ;
img3 = double(rgb2gray(imread('imagesequence/img3.ppm'))) ;
img4 = double(rgb2gray(imread('imagesequence/img4.ppm'))) ;



trainImage = img1;
featuresPerFern = 10;
numFerns = 20;
numWarpsPerTrainImage = 1000;
patchRadius = 15;  % size will be 2*15+1
maxHarrisPoints = 200;


% if ( exist(harrisPointsFileName, 'file') == 2 && exist(samplePointsFileName, 'file') == 2 && exist(histogramsFileName, 'file') == 2 )
%      [harrisPoints, samplePoints, histograms] = loadFerns(harrisPointsFileName,samplePointsFileName,histogramsFileName);
%  else
     % smooth(img1); ???
     [harrisPoints, samplePoints, histograms] = trainFerns(trainImage,featuresPerFern,numFerns,numWarpsPerTrainImage,patchRadius,maxHarrisPoints);
%      saveFerns(harrisPoints,harrisPointsFileName,samplePoints,samplePointsFileName,histograms,histogramsFileName);
% end;

%
% smooth(img2) ???

% for each harris-Point the location in image2 
% the histogram-bin it falls into
% and the probability to belong to this bin
[loc,bin,prob] = findMatchesWithFerns(img2,samplePoints,histograms,featuresPerFern,patchRadius,maxHarrisPoints);

% the point at location loc(:,n) fits best to harrisPoints(bin(n))



%
% % do the same as in last exercise (RANSAC, warping)






