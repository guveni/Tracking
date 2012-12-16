function [points] = getConsensusPoints(p,pos)
%GETCONSENSUSPOINTS returns a list containing points of p at position pos
%   Detailed explanation goes here
    
    points = zeros(3,size(pos,2));
    for i=1:size(pos,2)
        points(:,i) = p(:,pos(i));
    end


end

