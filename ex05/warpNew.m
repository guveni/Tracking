function [ WARP ] = warpNew( I, translMatrix )
%WARPNEW Summary of this function goes here
%   Detailed explanation goes here

    tform = maketform('affine',translMatrix);
    [WARP,xdata,ydata] = imtransform(I,tform);

    tform2 = maketform('affine',inv(translMatrix));
    
    sizeWarp = size(WARP);
end

