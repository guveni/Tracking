clear; close all;

tic()

img0 = double( rgb2gray(imread('./image_sequence/0000.png')) );
[height, width, d] = size(img0);

numImages = 5;

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


 plot3(results(4,:),results(5,:),results(6,:),'-ro')
 
hold on;
  plot3(points3D(1,:),points3D(2,:),points3D(3,:),'bx');
 
 %plot3(cams(1, :), cams(2, :), cams(3, :),'-go')
 
 
 A = [A [0;0;0]];
  A = [A;0 0 0 1];
  
for i=1:numImages
    [R,T]=getRotationTranslationMat(results(:,i));
    
    x = A*R*T* [1,0,0,1]';
    y = A*R*T* [0,1,0,1]';
    z = A*R*T* [0,0,1,1]';
    
    x=x./norm(x);
    y=y./norm(y);
    z=z./norm(z);
    
    plot3([0 x(1)],[0 x(2)],[0 x(2)],'-rx');
    plot3([0 y(1)],[0 y(2)],[0 y(2)],'-gx');
    plot3([0 z(1)],[0 z(2)],[0 z(2)],'-bx');


end
 
 
 grid on;
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 axis equal;

toc()
