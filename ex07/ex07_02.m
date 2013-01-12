clear;
close all;


img1 = double(rgb2gray(imread('./test_images/face1.jpg')));
img2 = double(rgb2gray(imread('./test_images/face2.jpg')));
img3 = double(rgb2gray(imread('./test_images/face3.jpg')));

intImg1 = constructIntegralImage(img1);
intImg2 = constructIntegralImage(img2);
intImg3 = constructIntegralImage(img3);

load('./Classifiers.mat');

%just for testing
% numClassifiers = size(classifiers, 2);
% for i = 2:5:numClassifiers
% 
%     haarlikeFeatures(classifiers(1:5, i), intImg1, 19)
%     
% end

% slidingWindow(classifiers, intImg1, img1);
slidingWindow(classifiers, intImg2, img2);
% slidingWindow(classifiers, intImg3, img3);

