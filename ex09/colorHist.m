function [ histogram ] = colorHist( patch )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

hsvImg = rgb2hsv(patch); %maybe more useful if done when loading each new sequence image, but for now it's fine here
[rows, cols, chans] = size(patch);

histogram = zeros(256, 1);

for r = 1:rows
    for c = 1:cols
        
        
        hue = round(hsvImg(r, c, 1)*255); %hue originally is in the range of [0, 1]
        histogram(hue + 1) = histogram(hue + 1) + 1;
        
    end
end

end