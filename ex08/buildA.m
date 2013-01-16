function [ A ] = buildA( img,gridX,gridY,rectangle )
%BUILDA Summary of this function goes here
%   Detailed explanation goes here



img = normalizeMatrix(img);
oriGridInt = getGridIntensities(img,gridX,gridY,eye(3));

numGridPoints = size(gridX,1)*size(gridX,2);

P = zeros(8,numGridPoints);
I = zeros(numGridPoints,numGridPoints);

A = zeros(8,numGridPoints,5);

for warpId = 1:5
    warpId
    for n = 1:numGridPoints  % random warps

       
        [warpImg,warpedGridInt,H,dp] = warpRectangle(img,rectangle,gridX,gridY,warpId*3);

        P(:,n) = dp;
        
        di = oriGridInt - warpedGridInt;
        di = reshape(di,numGridPoints,1);
        I(:,n) = di;
        

% 
%         figure(2);
%         imshow(warpImg,[-2 2]);
%         hold on;
%         plot(gridX,gridY,'bo');

    end
    A(:,:,warpId) = P*I'*(I*I');
end

end

