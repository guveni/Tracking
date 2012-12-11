function [ harrisPoints,matches,prob ] = findMatchesWithFerns( img,samplePoints,histograms,featuresPerFern, borderSize, maxPoints )
%FINDMATCHESWITHFERN Summary of this function goes here
%   Detailed explanation goes here

    harrisPoints = findRobustHarrisPoints(img,borderSize,maxPoints);

    n = size(harrisPoints,2);

    % set initial matches to -1 and prob 0
    matches = ones(1,n)*-1;
    prob = zeros(1,n);

    
    probOfPoint = ones(1,size(histograms,2));
    
    % for each harris-point
    for hp=1:n
        % TODO: find best value from histogram

        harrisPointX = harrisPoints(1,hp);
        harrisPointY = harrisPoints(2,hp);
            
        % for each fern
        for fernId=1:(size(samplePoints,1)/4)
            
            binPos = 0;
            
            % for each training-point
            for trainPointId=1:size(samplePoints,2)

                
                %compute bin in which a point falls
                samplePoint1X = harrisPointX+samplePoints(fernId*4-3,trainPointId);
                samplePoint1Y = harrisPointY+samplePoints(fernId*4-2,trainPointId);
                samplePoint2X = harrisPointX+samplePoints(fernId*4-1,trainPointId);
                samplePoint2Y = harrisPointY+samplePoints(fernId*4-0,trainPointId);
                
                if( img(samplePoint1Y,samplePoint1X) < img(samplePoint2Y,samplePoint2X) );
                    binPos = binPos + 2^(trainPointId-1);
                end
                
            end
            
            probOfPoint(1,:) = probOfPoint(1,:) .* histograms(featuresPerFern*(fernId-1)+1+binPos,:);
            
        end

        bestProb = max(probOfPoint);
        bestPos = find(probOfPoint == max(probOfPoint));
        matches(1,hp) = bestPos(1);
        prob(1,hp) = bestProb;

        
    end

end

