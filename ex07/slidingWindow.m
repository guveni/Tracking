function [ response ] = slidingWindow( classifier, img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[rows, cols] = size(img);
windowSize = [19; 38; 57; 76];

for w = 1:size(windowSize, 1);
    
    for r = 1:(rows - windowSize(w))
       for c = 1:(cols - windowSize(w))

           patch = img(r:r+windowSize(w) -1, c:c+windowSize(w) -1);

           response = haarlikeFeatures(classifier, patch, windowSize(w));
       end
    end
end

end

