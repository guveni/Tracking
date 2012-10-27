function [ filteredImg ] = applyMedianFilter( img,windowSize )
%APPLYMEDIANFILTER Exercise 02_01 a) applies a median-filter to an image
%   img: the image to apply the filter
%   windowSize: the size of the filter-window (1 means a filter-window of
%   1x1, means a window of 3x3, etc.
    
    [R,C] = size(img);
    
    s = floor(windowSize/2);
    
    filteredImg = zeros(R,C);
    
    for r = 1:1:R
       for c = 1:1:C
          result = zeros(windowSize*windowSize,1); 
          insertPos = 1;
          for y = -s:1:s
            for x = -s:1:s
                % simple border treatment
                pixelPosY = max(min(r+y,R),1);
                pixelPosX = max(min(c+x,C),1);
                
                result(insertPos) = img(pixelPosY,pixelPosX);
                insertPos = insertPos+1;
            end
          end
          
          result = sort(result);  % sort neighborhood-pixels
          filteredImg(r,c) = result(ceil(windowSize*windowSize/2)); % apply median-value of neighbors to output-image
                
       end
    end
    
    filteredImg = uint8(filteredImg);
    
end

