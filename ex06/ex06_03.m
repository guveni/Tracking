clear; close all;

tic()

img0 = double( rgb2gray(imread('./image_sequence/0000.png')) );
[height, width, d] = size(img0);
numImages = 45;

A = [472.3 0.64 329.0; 0 471.0 268.3; 0 0 1];

[points3D, framesT0, descriptorsT0] = initTracking(img0);

% imshow(img1, [0 255]);
% for i=1:size(framesT0, 2);
%     
%     hold on;
%     plot(framesT0(1, i), framesT0(2, i), 'xr');
%     hold off;
%     
% end


image = zeros(height, width);
% correspondences = zeros(height, width, 2*(numImages-1));
% homographies = zeros(3, 3, numImages-1);

xOld = [0;0;0;0;0;1];

results = zeros(6,numImages);

cam0 = [0;0;0;1];
cams = zeros(4, numImages);
cams(:, 1) = cam0;

for i=0:numImages-1
  	i
    if(i < 10)
        filename = sprintf('./image_sequence/000%d.png', i);
    else
        filename = sprintf('./image_sequence/00%d.png', i);
    end
    
    currImg = single(rgb2gray(imread(filename)));
    image(:, :) = currImg;

    [m1,m2,cons,H,M] = computeCorrespondences(image(:, :), framesT0, descriptorsT0,points3D);
    
    funcHandle = @(xOld) energyFunction(A,xOld,M,m2);
    [xOld,e] = fminsearch(funcHandle, xOld);
    
    results(:,i+1) = xOld;
    xOld
    e

    if i>0
        [R, T] = getRotationTranslationMat(xOld);
        cams(:, i+1) = R*T*cams(:, i);
    end
end


 %plot3(results(4,:),results(5,:),results(6,:),'-ro')
 plot3(cams(1, :), cams(2, :), cams(3, :),'-ro')
 
 grid on;
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 axis equal;

toc()

input('press any key to finish');
close all;