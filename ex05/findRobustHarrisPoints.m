function [ resPoints ] = findRobustHarrisPoints( img , borderSize, maxPoints)
%FINDROBUSTHARRISPOINTS Summary of this function goes here
%   Detailed explanation goes here

% TODO: do warping (see comment below)
% TODO: search for more than 5 harris-points
harrisPoints = corner(img,'Harris',maxPoints)';

[m,n] = size(img);


% delete harrisPoints near border
resPoints = zeros(2,size(harrisPoints,2));
ctr = 0;
for i=1:size(harrisPoints,2)
    
    p1x = harrisPoints(1,i);
    p1y = harrisPoints(2,i);    
    
    if ( p1x < borderSize+1 || p1y < borderSize+1 ||p1x > n-15 || p1y > m-15 )
        a = 5;
    else
        ctr = ctr+1;
        resPoints(:,ctr) = harrisPoints(:,i);
    end
end

resPoints = resPoints(:,1:ctr);

% warp patch around harrisPoints and see if harrisPoint is robust enough
% R? R?? diag(?1,?2) R?
%the rotation angles are randomly chosen from [0;2pi]
%?1,?2 are randomly chosen from [0.6; 1.5]

backwarps = 10;

theta = (2*pi) * rand(backwarps, 1);
phi = (2*pi) * rand(backwarps, 1);

lambdas = 0.6 + 0.9 * rand(backwarps, 2);

%build the rotation/scale matrices
rotationTheta = zeros(2, 2, backwarps);
rotationPhi = zeros(2, 2, backwarps);
invRotationPhi = zeros(2, 2, backwarps);
scaling = zeros(2, 2, backwarps);

for i=1:backwarps
   
    rotationTheta(:,:,i) = [cos(theta(i)) sin(theta(i));
                            -sin(theta(i)) cos(theta(i))];
                
    rotationPhi(:,:,i) = [cos(phi(i)) sin(phi(i));
                        -sin(phi(i)) cos(phi(i))];
                
    invRotationPhi(:,:,i) = [cos(phi(i)) -sin(phi(i)); 
                            sin(phi(i)) cos(phi(i))];
                
    scaling(:,:,i) = [lambdas(i, 1) 0;
                    0 lambdas(i, 2)];

end

%now we use the matrices on every point in the patch of every harrisPoint
%and build new image patches
%patches = ones(size(resPoints, 1), backwarps, 2*borderSize+1, 2*borderSize+1) * -1;
patches = ones(2*borderSize+1, 2*borderSize+1, backwarps, size(resPoints, 1)) * -1;

for h = 1:size(resPoints, 1)
    x = resPoints(1,h); %not sure if correct (are harris corners stored as (x, y)T or (y, x)T ?
    y = resPoints(2,h);
    [x, y]
    for b = 1:backwarps

        tempPatch = img(y-borderSize : y+borderSize, x-borderSize : x+borderSize);

        transformation = rotationTheta(:, :, b) * invRotationPhi(:, :, b) * scaling(:, :, b) * rotationPhi(:, :, b);
        transformation = [transformation, [0;0]];
        transformation = [transformation; [0 0 1]];
        tform = maketform('affine', transformation);

        transImage = imtransform(tempPatch, tform, 'XData', [1 2*borderSize+1], 'YData', [1 2*borderSize+1], 'FillValues', -1);
        patches(:, :, b, h) = transImage;

        
        %produce noise for undefined image points (i.e. no point was warped
        %to this position
        for r = 1 : 2 * borderSize + 1
            for c = 1 : 2 * borderSize + 1
                if(patches(r, c, b, h) == -1)
                   if(randi(2) == 1)
                       patches(r, c, b, h) = 0;
                   else
                       patches(r, c, b, h) = 255;
                   end
                end
            end
        end
    end
end

for i = 1:size(patches, 3)
    for j = 1:size(patches, 4)
        
        figure();
        imshow(patches(:,:,i,j), [0 255]);
        
    end
end


% accHarrisPoints = zeros(size(img))
%
% for i=1:1000
%   warpMatrix = buildRandomAffineTransformMatrix()
%   warpImg = warpImage(img,warpMatrix)
%   harPoints = findHarrisPoints()
%   
%   harPoints = warpPoints(harPoints,warpMatrix^-1)
%
%   for each harPoint in harPoints
%      accHarrisPoints(harPoint) = accHarrisPoints(harPoint)+1;
%   end
% end
%
% bestHarPoints =  bestfindBestPointsWithinPatch(accHarrisPoints);

end

