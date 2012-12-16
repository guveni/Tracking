
close all;

% filenames for saving
harrisPointsFileName = 'harrisPoints.model';
samplePointsFileName = 'samplePoints.model';
histogramsFileName = 'histogram.model';

% read in images
img1 = double(rgb2gray(imread('imagesequence/img1.ppm'))) ;
img2 = double(rgb2gray(imread('imagesequence/img2.ppm'))) ;
img3 = double(rgb2gray(imread('imagesequence/img3.ppm'))) ;
img4 = double(rgb2gray(imread('imagesequence/img4.ppm'))) ;




% define parameters
smoothing = 15;
featuresPerFern = 5;
numFerns = 1;
numWarpsPerTrainImage = 1;
patchRadius = 5;  % size will be 2*15+1
maxHarrisPoints = 5;

% 15 15 10 180 10 30 -> 8
% 15 15 10 180 10 30 -> 7
% 15 15 10 180  5 30 -> 8
% 15 15 10 100  5 30 -> 7
% 15 10 10 100  5 30 -> 5
% 15 17 10 180  5 30 -> 11
% 15 16 10 120  5 30 -> 11

% smooth image
smoothKernel = fspecial('gaussian',smoothing,1);
trainImage = imfilter(img1,smoothKernel);
testImage = trainImage;


trainAlways = 1;

   if ( trainAlways == 0 && exist(harrisPointsFileName, 'file') == 2 && exist(samplePointsFileName, 'file') == 2 && exist(histogramsFileName, 'file') == 2 )
        [harrisPoints, samplePoints, histograms] = loadFerns(harrisPointsFileName,samplePointsFileName,histogramsFileName);
    else
     % smooth(img1); ???
     [harrisPoints, samplePoints, histograms] = trainFerns(trainImage,featuresPerFern,numFerns,numWarpsPerTrainImage,patchRadius,maxHarrisPoints);
     %saveFerns(harrisPoints,harrisPointsFileName,samplePoints,samplePointsFileName,histograms,histogramsFileName);
   end;

%
% smooth(img2) ???

% for each harris-Point the location in image2 
% the histogram-bin it falls into
% and the probability to belong to this bin
% [loc,bin,prob] = findMatchesWithFerns(img2,samplePoints,histograms,featuresPerFern,patchRadius,maxHarrisPoints);
[loc,bin,prob] = findMatchesWithFerns(testImage,samplePoints,histograms,featuresPerFern,patchRadius,maxHarrisPoints);

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

offsetX = size(trainImage,2);
offsetY = size(trainImage,1);

canvas = zeros(max(offsetY,size(testImage,1)),offsetX+size(testImage,2));
canvas(1:offsetY,1:offsetX) = trainImage;
canvas(1:size(testImage,1),offsetX+1:offsetX+size(testImage,2)) = testImage;




figure();
imshow(canvas,[0 255]);

hold on;
for i=1:size(loc,2)
  plot(loc(1,i)+offsetX,loc(2,i),'xr'); 
  b = bin(i);
  plot(harrisPoints(1,i),harrisPoints(2,i),'oy'); 
  t = loc(:,i)-harrisPoints(:,b);
   a(:,i) = t;
   
   if( norm(t(1)) < 20 && norm(t(2)) < 20 )
        plot([harrisPoints(1,b),loc(1,i)+offsetX],[harrisPoints(2,b),loc(2,i)],'-b'); 
   else
       plot([harrisPoints(1,b),loc(1,i)+offsetX],[harrisPoints(2,b),loc(2,i)],'-r'); 
   end
end
hold off;






%
% % do the same as in last exercise (RANSAC, warping)






