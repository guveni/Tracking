function [ gridIntensities ] = getGridIntensities( img,gridX,gridY )
%GETGRIDINTENSITIES Summary of this function goes here
%   Detailed explanation goes here

    numGridPoints = size(gridX,1);
    gridIntensities = zeros(numGridPoints,numGridPoints);

    for r=1:numGridPoints
        for c=1:numGridPoints
                gridIntensities(r,c) =  img( round( gridY(r,c) ), round( gridX(r,c) ) );
        end
    end

end

