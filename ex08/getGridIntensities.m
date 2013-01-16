function [ gridIntensities ] = getGridIntensities( img,gridX,gridY,M )
%GETGRIDINTENSITIES Summary of this function goes here
%   Detailed explanation goes here

    numGridPoints = size(gridX,1);
    gridIntensities = zeros(numGridPoints,numGridPoints);

    for r=1:numGridPoints
        for c=1:numGridPoints
                p = round(normalizePoints( M*[gridX(r,c);gridY(r,c);1] ));
                gridIntensities(r,c) =  img( p(2),  p(1)  );
        end
    end

end

