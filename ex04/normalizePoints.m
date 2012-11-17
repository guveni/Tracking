function [ p ] = normalizePoints( p )
%NORMALIZEPOINTS Summary of this function goes here
%   Detailed explanation goes here

    for i=1:size(p,2)
       if p(end,i) ~= 0
            p(:,i) = p(:,i) ./ p(end,i);
       end
    end

end

