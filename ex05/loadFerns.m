function [harrisPoints, samplePoints, histograms] = loadFerns( harrisPointsFileName,samplePointsFileName,histogramsFileName )
%LOADFERNS Summary of this function goes here
%   Detailed explanation goes here

    harrisPoints = dlmread(harrisPointsFileName);
    samplePoints = dlmread(samplePointsFileName);
    histograms = dlmread(histogramsFileName);
end

