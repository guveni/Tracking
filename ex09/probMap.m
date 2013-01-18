function [ probDist ] = probMap( region, histogram )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    [rows,cols,dims] = size(region);
    
    
    probDist = zeros(rows,cols);
    
    for r=1:rows
        for c=1:cols
            probDist(r,c) = histogram( round( region(r,c,1)*255+1 ) );
        end
    end
    

end

