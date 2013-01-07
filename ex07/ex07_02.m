img1 = rgb2gray(imread('./test_images/face1.jpg'));
img2 = rgb2gray(imread('./test_images/face2.jpg'));
img3 = rgb2gray(imread('./test_images/face3.jpg'));

intImg1 = constructIntegralImage(img1);
% intImg2 = constructIntegralImage(img2);
% intImg3 = constructIntegralImage(img3);

load('./Classifiers.mat');

haarlikeFeatures(classifiers(1:5, 50), intImg1)