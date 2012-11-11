function [ maximaMatrix ] = findLocalMaxima( m, radius )
%FINDLOCALMAXIMA finds local maxima in an matrix
%   m: matrix in which local maxima should be found
%   radius: the radius in which the point has to be maximal

[R C] = size(m);

maximaMatrix = ones(R,C);

for r = 1:R
    for c = 1:C
        for y=-radius:1:radius
            for x=-radius:1:radius
                yClamped = max(min(r+y,C),1);
                xClamped = max(min(c+x,R),1);
                
                centerIntensity = m(r,c);
                intensity = m(yClamped,xClamped);
                
                if(intensity > centerIntensity)
                    maximaMatrix(r,c) = 0;
                end
            end
        end
    end
end

end

