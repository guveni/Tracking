function [ histogram ] = colorHist( imgHsv )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[rows, cols,dim] = size(imgHsv);

histogram = zeros(256, 1);

for r = 1:rows
    for c = 1:cols
        
        
        hue = round(imgHsv(r, c, 1)*255); %hue originally is in the range of [0, 1]
        histogram(hue + 1) = histogram(hue + 1) + 1;
        
    end
end


end