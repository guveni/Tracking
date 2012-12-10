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
rotationTheta = zeros(backwarps, 2, 2);
rotationPhi = zeros(backwarps, 2, 2);
invRotationPhi = zeros(backwarps, 2, 2);
scaling = zeros(backwarps, 2, 2);

for i=1:backwarps
   
    rotationTheta(i,:,:) = [cos(theta(i)) sin(theta(i));
                            -sin(theta(i)) cos(theta(i))];
                
    rotationPhi(i,:,:) = [cos(phi(i)) sin(phi(i));
                        -sin(phi(i)) cos(phi(i))];
                
    invRotationPhi(i,:,:) = [cos(phi(i)) -sin(phi(i)); 
                            sin(phi(i)) cos(phi(i))];
                
    scaling(i,:,:) = [lambdas(i, 1) 0;
                    0 lambdas(i, 2)];

end

%now we use the matrices on every point in the patch of every harrisPoint
%and build new image patches
patches = ones(size(harrisPoints, 1), backwarps, 2*borderSize+1, 2*borderSize+1) * -1;

for h = 1:size(harrisPoints, 1)
    x = harrisPoints(1,h); %not sure if correct (are harris corners stored as (x, y)T or (y, x)T ?
    y = harrisPoints(2,h);
    for b = 1:backwarps
        for r = -borderSize:borderSize
            for c = -borderSize:borderSize

                point = img(y+r, x+c);
                transformed = (((rotationTheta(b) * rotationPhi(b)) * scaling(b)) * invRotationPhi(b)) * transpose([y+r x+c])
                %looks like it doesn't work that easy...
                %the transformed coordinates are in every warp almost the
                %same
                if (transformed(1) > y - borderSize && transformed(1) < y + borderSize && ...
                    transformed(2) > x - borderSize && transformed(2) < x + borderSize)
                    
                    patches(h, b, int32(transformed(1)), int32(transformed(2))) = point;
                    
                end

            end
        end

        %produce noise for undefined image points (i.e. no point was warped
        %to this position
        for r = 1 : 2 * borderSize + 1
            for c = 1 : 2 * borderSize + 1
                if(patches(h, b, r, c) == -1)
                   if(randi(2) == 1)
                       patches(h, b, r, c) = 0;
                   else
                       patches(h, b, r, c) = 255;
                   end
                end
            end
        end
    end
end

for i = 1:size(patches, 2)
    
%     figure();
%     imshow(patches(1, i), [0 255]);
   
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

