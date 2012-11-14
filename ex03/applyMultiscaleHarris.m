function [ harrisPoints ] = applyMultiscaleHarris( img,s0,k,n,alpha,t,nonMaxRadius )
%APPLYMULTISCALEHARRIS applies a multiscale-harris-filter to an image
%   img: input-image
%   s0: 

    R = computeResponse(img,s0,k,n,alpha);

    % matrix containing 1 for all fields where R > 1000
    threshold = (R>t);

    localMaxima = findLocalMaxima(R,nonMaxRadius);

     harrisPoints = localMaxima.*threshold;
end

