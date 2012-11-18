function [ H,consMax ] = doAdaptiveRansac( p1,p2,s,t,p )
%DOADAPTIVERANSAC Summary of this function goes here
%   p1: points in img1
%   p2: points in img2
%   s: number of points regarded at a time (minimum count of points for DLT is 4)
%   t: threshold for distance
%   p: probability to have best solution

% N = inf, sample_count = 0.
%
%  While N > sample_count repeat
%       – Choose a sample and count the number of inliers.
%       – Set e = 1 - (number_of_inliers)/(total_number_of_points).
%       – Set N = log(1 - p) / log(1 - (1 - e)^s).
%       – Increment sample_count by 1.
%  Terminate.

    numPoints = size(p1,2);

    p1 = normalizePoints(p1);
    p2 = normalizePoints(p2);
    
    N = inf;
    sample_count = 0;

    consMax = [];
    numMaxInliers = 0;
    
    while N > sample_count
       selPoints = selectSamples(s,numPoints);

       dltPoints1 = zeros(3,s);
       dltPoints2 = zeros(3,s);

       for ii=1:s
          dltPoints1(:,ii) = p1(:,selPoints(ii));
          dltPoints2(:,ii) = p2(:,selPoints(ii));
       end

       H = doDLT(dltPoints1,dltPoints2);

       calcP2 = H*p1;
       calcP2 = normalizePoints(calcP2);

       currCons = [];

       for ii=1:numPoints
           if norm( p2(:,ii) - calcP2(:,ii) ) < t
               currCons = [currCons ii];
           end
       end

       numCurrInliers = size(currCons,2);

       if numCurrInliers > size(consMax,2)
           consMax = currCons;
           numMaxInliers = numCurrInliers;
       end
       
       e = 1 - (numMaxInliers)/(numPoints);
       N = log(1 - p)/log(1 - (1 - e)^s);

       sample_count = sample_count+1;
    end

    consPoints1 = getConsensusPoints(p1,consMax);
    consPoints2 = getConsensusPoints(p2,consMax);
    
    H = doDLT(consPoints1,consPoints2);



end

