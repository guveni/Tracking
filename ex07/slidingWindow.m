function [ response ] = slidingWindow( classifier, intImg, img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[rows, cols] = size(intImg);
windowSize = [19; 38; 57; 76];

for w = 1:size(windowSize, 1);
    
    currWinSize = windowSize(w);
    
    for r = 1:(rows - currWinSize)
       for c = 1:(cols - currWinSize)

           patch = intImg(r:r+currWinSize -1, c:c+currWinSize -1);

           figure(1);
           imshow(img(r:r+currWinSize -1, c:c+currWinSize -1),[0 255]);
           
           response = 0;
           
           for cId = 2:size(classifier,2)
               response = response + haarlikeFeatures(classifier(:,cId), patch, currWinSize);
           end
       end
    end
end

end
