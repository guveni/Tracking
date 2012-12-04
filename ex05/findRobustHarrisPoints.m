function [ resPoints ] = findRobustHarrisPoints( img , borderSize, maxPoints)
%FINDROBUSTHARRISPOINTS Summary of this function goes here
%   Detailed explanation goes here

% TODO: do warping (see comment below)
% TODO: search for more than 5 harris-points
harrisPoints = corner(img,'Harris',maxPoints)';

[m,n] = size(img)


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

