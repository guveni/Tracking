function [ p ] = normalizePoints( p )
%NORMALIZEPOINTS normalize vektors 

    for i=1:size(p,2)
       if p(end,i) ~= 0
            p(:,i) = p(:,i) ./ p(end,i);
       end
    end

end

