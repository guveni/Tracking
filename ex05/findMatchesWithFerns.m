function [ harrisPoints,bin,prob ] = findMatchesWithFerns( img,samplePoints,histograms, borderSize, maxPoints )
%FINDMATCHESWITHFERN Summary of this function goes here
%   Detailed explanation goes here

    harrisPoints = findRobustHarrisPoints(img,borderSize,maxPoints);

    n = size(harrisPoints,2);

    % set initial matches to -1 and prob 0
    bin = ones(1,n)*-1;
    prob = zeros(1,n);

    for i=1:n
        % TODO: find best value from histogram
    end

end

