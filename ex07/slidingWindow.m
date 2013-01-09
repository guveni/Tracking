function [ response ] = slidingWindow( classifiers, intImg, img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


c_mean = 6;
c_maxPos = 8;
c_minPos = 9;
c_R = 10;
c_alpha = 11;


[rows, cols] = size(intImg);
windowSize = [19; 38; 57; 76];



for w = 1:size(windowSize, 1);  % different sizes
    
    currWinSize = windowSize(w);
    
    for r = 1:(rows - currWinSize)  % different window positions
       for c = 1:(cols - currWinSize)

           patch = intImg(r:r+currWinSize -1, c:c+currWinSize -1);

           figure(1);
           imshow(img(r:r+currWinSize -1, c:c+currWinSize -1),[0 255]);
           
           response = 0;
           
           correct = 1;
           
           for cId = 2:size(classifiers,2)
               
               classifier = classifiers(:,cId);
               
               
               alpha = classifier(c_alpha);
               
               currResponse = haarlikeFeatures(classifier, patch, currWinSize);
               
               
               mean = classifier(c_mean);
               minPos = classifier(c_minPos);
               maxPos = classifier(c_maxPos);
               R = classifier(c_R);
               
               left = (mean - abs(mean-minPos) * (R-5)/50);
               right = (mean + abs(maxPos - mean) * (R-5)/50);
               weightedResponse = alpha * currResponse;
               
                if left <= weightedResponse && weightedResponse <= right
                    correct = 0;
                    break;
                end
               
%                if minPos <= weightedResponse && weightedResponse <= maxPos
%                    correct = 0;
%                    break;
%                end
               
               response = response + weightedResponse;
               
           end
           
           if correct == 1
               disp('face!!!');
           end
            
       end
    end
end

end
