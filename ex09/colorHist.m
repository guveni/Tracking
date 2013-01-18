function [ histogram ] = colorHist( imgHsv,numBins )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[rows, cols,dim] = size(imgHsv);

histogram = zeros(numBins, 1);

for r = 1:rows
    for c = 1:cols
        
        
        hue = round(imgHsv(r, c, 1)*(numBins-1)); %hue originally is in the range of [0, 1]
        histogram(hue + 1) = histogram(hue + 1) + 1;
        
    end
end


end