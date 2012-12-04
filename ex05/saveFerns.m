function [  ] = saveFerns( harrisPoints,harrisPointsFileName,samplePoints,samplePointsFileName,histograms,histogramsFileName )
%SAVEFERNS Summary of this function goes here
%   Detailed explanation goes here

    dlmwrite(harrisPointsFileName,harrisPoints);
    dlmwrite(samplePointsFileName,samplePoints);
    dlmwrite(histogramsFileName,histograms);

end

