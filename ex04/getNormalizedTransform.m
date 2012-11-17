function [ M ] = getNormalizedTransform( p )
%GETNORMALIZEDTRANSFORM Summary of this function goes here
%   Detailed explanation goes here

    N = size(p,2);
    
    centerX = mean(p(1,:));
    centerY = mean(p(2,:));

    centralisedX = (p(1,:)-ones(1,N)*centerX);
    centralisedY = (p(2,:)-ones(1,N)*centerY);

    dist = mean(  sqrt(  centralisedX.^2  +  centralisedY.^2  )  ) ;
        
    scale = sqrt(2)/dist;
    
    sR = [scale       0  0;
               0  scale  0;
               0      0  1];

    tR = [ 1 0 -centerX;
           0 1 -centerY;
           0 0        1;];
                 
                 
    M = sR*tR;

end

