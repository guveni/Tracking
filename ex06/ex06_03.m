clear; close all;

tic()

img0 = double( rgb2gray(imread('./image_sequence/0000.png')) );
[height, width, d] = size(img0);

% number of images. maximum is 45
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

%xOld = [0;0;0;0;0;1];
xOld = [0;0;0;0;0;0];

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
        %cams(:, i+1) = R*T*cams(:, i);
        cams(:, i+1) = [R(:, 1:3) T(:, 4)]*cams(:, i);
        
    end
end



  plot3(points3D(1,:),points3D(2,:),points3D(3,:),'bx');
 
  hold on; 
      
 %plot3(cams(1, :), cams(2, :), cams(3, :),'-go')
 
 
A = [A [0;0;0]];
A = [A;0 0 0 1];
  
poses=ones(4,numImages);

for i=1:numImages
     [R,T]=getRotationTranslationMat(results(:,i));
    
%     p=A*R*T*[results(4,i);results(5,i);results(6,i);1];

    rr = -transpose(R(1:3, 1:3));
    rr = [rr; 0 0 0];
    rt = [ rr T(:, 4)];
    
%    p = -R'*T*[0;0;0;1];
    p = (rt)*[0;0;0;1];

    p = normalizePoints(p);
%     plot3(results(4,:),results(5,:),results(6,:),'-ro')
%     plot3(p(1,1),p(2,1),p(3,1),'-ro')
 
poses(:,i) = p;

    text(p(1,1),p(2,1),p(3,1)+.1,sprintf('%d',i-1));
    
%     o = A*R*T*[0,0,0,1]';
%     
%     x = A*R*T* [1,0,0,1]';
%     y = A*R*T* [0,1,0,1]';
%     z = A*R*T* [0,0,1,1]';
%     
%     o=o./norm(o);
%     
%     x=x./norm(x);
%     y=y./norm(y);
%     z=z./norm(z);
%     
%     plot3([o(1) x(1)],[o(2) x(2)],[o(3) x(2)],'-rx');
%     plot3([o(1) y(1)],[o(2) y(2)],[o(3) y(2)],'-gx');
%     plot3([o(1) z(1)],[o(2) z(2)],[o(3) z(2)],'-bx');


end
 
plot3(poses(1,:),poses(2,:),poses(3,:),'-ro')
 
 grid on;
 xlabel('X')
 ylabel('Y')
 zlabel('Z')
 axis equal;
 
 



toc()

