function [ H ] = doRansac( p1,p2, s, t, T, N)
%DORANSAC Summary of this function goes here
%   Detailed explanation goes here
%   p1: points in img1
%   p2: points in img2
%   s: number of points regarded at a time
%   t: threshold for distance
%   T: threshold for number of inliers
%   N: max-iterations

    consMax = [];
    num = size(p1,2);
    
    p1 = normalizePoints(p1);
    p2 = normalizePoints(p2);
    
    for i=1:N
        selPoints = selectPositions(s,size(p1,2));
        
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
        
        for ii=1:num
            if norm( p2(:,ii) - calcP2(:,ii) ) < t
                currCons = [currCons ii];
            end
        end
        
        if size(currCons,2) > size(consMax,2)
            consMax = currCons;
        end
        
        if size(currCons,2) >= T
            break;
        end
        
        
    end;
    
    consPoints1 = getConsensusPoints(p1,consMax);
    consPoints2 = getConsensusPoints(p2,consMax);
    
    H = doDLT(consPoints1,consPoints2);
    
%     a) Randomly select a sample of s data points from S and instantiate the model from this
%     subset.    
%     
%     b) Determine the set of data points Si that are within a distance threshold t of the model.
%     The set Si is the consensus set of the sample and defines the inliers of S.
%     
%     c) If the size of Si (the number of inliers) is greater than some threshold T, re-estimate
%     the model using all the points in Si and terminate.
%     
%     d) If the size of Si is less than T, select a new subset and repeat the above.
%     
%     e) After N trials the largest consensus set Si is selected, and the model is re-estimated
%     using all the points in the subset Si.
    
end

function [pos] = selectPositions(nSelect,nAll)
    list = linspace(1,nAll,nAll);
    pos = zeros(1,nSelect);
    
    for i=1:nSelect
        r = randi(size(list));
        pos(i) = list(r);
        list(r) = [];
    end
    
end

function [points] = getConsensusPoints(p,pos)
    
    points = zeros(3,size(pos,2));
    for i=1:size(pos,2)
        points(:,i) = p(:,pos(i));
    end
end