
close all;

harrisPointsFileName = 'harrisPoints.model';
samplePointsFileName = 'samplePoints.model';
histogramsFileName = 'histogram.model';

img1 = double(rgb2gray(imread('imagesequence/img1.ppm'))) ;
img2 = double(rgb2gray(imread('imagesequence/img2.ppm'))) ;
img3 = double(rgb2gray(imread('imagesequence/img3.ppm'))) ;
img4 = double(rgb2gray(imread('imagesequence/img4.ppm'))) ;



trainImage = img1;
featuresPerFern = 5;
numFerns = 2;
numWarpsPerTrainImage = 500;
patchRadius = 5;  % size will be 2*15+1
maxHarrisPoints = 15;

trainAlways = 1;

   if ( trainAlways == 0 && exist(harrisPointsFileName, 'file') == 2 && exist(samplePointsFileName, 'file') == 2 && exist(histogramsFileName, 'file') == 2 )
        [harrisPoints, samplePoints, histograms] = loadFerns(harrisPointsFileName,samplePointsFileName,histogramsFileName);
    else
     % smooth(img1); ???
     [harrisPoints, samplePoints, histograms] = trainFerns(trainImage,featuresPerFern,numFerns,numWarpsPerTrainImage,patchRadius,maxHarrisPoints);
       saveFerns(harrisPoints,harrisPointsFileName,samplePoints,samplePointsFileName,histograms,histogramsFileName);
   end;

%
% smooth(img2) ???

% for each harris-Point the location in image2 
% the histogram-bin it falls into
% and the probability to belong to this bin
% [loc,bin,prob] = findMatchesWithFerns(img2,samplePoints,histograms,featuresPerFern,patchRadius,maxHarrisPoints);
[loc,bin,prob] = findMatchesWithFerns(trainImage,samplePoints,histograms,featuresPerFern,patchRadius,maxHarrisPoints);

% the point at location loc(:,n) fits best to harrisPoints(bin(n))

figure();
imshow(trainImage,[0 255]);
hold on;
for i=1:size(loc,2)
  plot(loc(1,i),loc(2,i),'xr'); 
  b = bin(i);
  plot(harrisPoints(1,b),harrisPoints(2,b),'oy'); 
   
   a(:,i) = loc(:,i)-harrisPoints(:,b);
   
  plot([harrisPoints(1,b),loc(1,i)],[harrisPoints(2,b),loc(2,i)],'-b'); 
end


hold off;

%
% % do the same as in last exercise (RANSAC, warping)






