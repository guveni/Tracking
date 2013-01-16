function [ M ] = normalizeMatrix( M )
%NORMALIZEMATRIX Summary of this function goes here
%   Detailed explanation goes here

    meanVal = mean( M( ~isnan(M) ) );
    M = M - meanVal;

    stdDev = std( M (~isnan(M) ) );
    M = M / stdDev;

end

