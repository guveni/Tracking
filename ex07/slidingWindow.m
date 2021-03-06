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

figure(3);
imshow(img,[0 255]);
hold on;

for w = 1:size(windowSize, 1);  % different sizes
    
    currWinSize = windowSize(w);
    
    for r = 1:2:(rows - currWinSize)  % different window positions
       for c = 1:2:(cols - currWinSize)

           patch = intImg(r:r+currWinSize -1, c:c+currWinSize -1);

%            figure(1);
%            imshow(img(r:r+currWinSize -1, c:c+currWinSize -1),[0 255]);
           
           response = 0;
           alphaSum = 0;
           
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
               
%                 weightedResponse = alpha * currResponse;
               
%                 if left <= weightedResponse && weightedResponse <= right
                if left <= currResponse && currResponse <= right
                    response = response + alpha * -1;
                else
                    response = response + alpha * 1;
                end
         
%                alphaSum = alphaSum + alpha;
           end
           
%            if response > 0.5*alphaSum
           if response > 0.9

               disp('face!!!');
               figure(2);
               imshow(img(r:r+currWinSize -1, c:c+currWinSize -1),[0 255]);
               
               figure(3);
               plot([c c+currWinSize c+currWinSize c c], [r r r+currWinSize r+currWinSize r],'r-');
           end
            
       end
    end
end

end
