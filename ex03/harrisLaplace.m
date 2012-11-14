function [ output_args ] = harrisLaplace( resolutionLevels, img, s0, k ,alpha, tHigh, tLow )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [R, C] = size(img);
    nonMaxSupprRadius = 1;
    
    response = computeResponse(img, s0, k,resolutionLevels, alpha);
    
    thresholded = (response > tHigh);
   
    localMaxima = findLocalMaxima(response, nonMaxSupprRadius);
    
    harrisPoints = localMaxima.*thresholded;
    
    laplaceMask = zeros(R, C, resolutionLevels);
    
    for i = 1:resolutionLevels
        s_L = s0 * k^i;   
        laplaceMask(:,:,i) = s_L * s_L * imfilter(img,fspecial('log', floor(6 * s_L + 1), s_L),'replicate');
    end
    
end

