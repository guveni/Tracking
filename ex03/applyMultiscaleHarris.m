function [ harrisPoints ] = applyMultiscaleHarris( img,s0,k,n,alpha,t )
%APPLYMULTISCALEHARRIS applies a multiscale-harris-filter to an image
%   img: input-image
%   s0: 

    R = computeResponse(img,1.5,1.2,1,0.04);

    % matrix containing 1 for all fields where R > 1000
    threshold = (R>t);

    localMaxima = findLocalMaxima(R.*threshold,nonMaxSupprRadius);

    harrisPoints = localMaxima.*threshold;
    
end

