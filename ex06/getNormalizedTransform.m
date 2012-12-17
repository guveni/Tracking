function [ M ] = getNormalizedTransform( p )
%GETNORMALIZEDTRANSFORM 
% returns matrix that translates points in the way that the origin is in
% the center of them and scales them so that their average distance to
% origin is sqrt(2)

    N = size(p,2);
    
    % calc center of points
    centerX = mean(p(1,:));
    centerY = mean(p(2,:));

    % move points so that origin is in the center
    centralisedX = (p(1,:)-ones(1,N)*centerX);
    centralisedY = (p(2,:)-ones(1,N)*centerY);

    % calc average distance of points to origin
    dist = mean(  sqrt(  centralisedX.^2  +  centralisedY.^2  )  ) ;
        
    % scale so that average distance will become sqrt(1)
    scale = sqrt(2)/dist;
    
    % matrix for scaling
    sR = [scale       0  0;
               0  scale  0;
               0      0  1];

    % matrix for translation
    tR = [ 1 0 -centerX;
           0 1 -centerY;
           0 0        1;];
                 
    % build matrix for translation + scaling              
    M = sR*tR;

end

