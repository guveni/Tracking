function [ newPoint ] = calcPointAfterWarping( point, sizeI,sizeWarp, H2, forward )
%CALCPOINTAFTERWARPING Summary of this function goes here
%   Detailed explanation goes here
% H2 is affine transform matrix
% point that should be translated



    sX = sizeI(2);
    sY = sizeI(1);

    swX = sizeWarp(2);
    swY = sizeWarp(1);
    
    
    tform = maketform('affine',H2);

    tform2 = maketform('affine',inv(H2));
    
    
    if(forward == 1) 
        
        p2rel = point - [swX/2;swY/2;0];

        p1rel = zeros(3,1);
        [p1rel(1) p1rel(2)] = tformfwd( tform2,p2rel(1),p2rel(2));
        p1rel(3) = 0;
        %p1rel = H2 * p2rel;
        newPoint = p1rel + [sX/2;sY/2;0];
        
    else
        p11rel = point - [sX/2;sY/2;0];

        p22rel = (H2) \ p11rel;
        [p22rel(1) p22rel(2)] = tformfwd( tform,p11rel(1),p11rel(2));

        newPoint = p22rel + [swX/2;swY/2;0];
    end

    newPoint = round(newPoint);
end



