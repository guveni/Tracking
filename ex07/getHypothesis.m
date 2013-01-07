function [ h ] = getHypothesis( hypo,alphas ,X,Y)
%GETHYPOTHESIS Summary of this function goes here
%   Detailed explanation goes here
    horizontal = 1;
    vertical = 2;

    h = zeros(size(X));
    
    for c=1:size(X,2)
        for r=1:size(X,1)

            T = size(hypo,1);
          
            for t=1:T

                dir = hypo(t,1);
                pos = hypo(t,2);
                aboveOrBelow = hypo(t,3);

                if(dir == horizontal)
                    coord = Y(r,c);
                else
                    coord = X(r,c);
                end

                if( (coord < pos) )
                    ht=-1;
                else
                    ht=1;
                end

                if aboveOrBelow==2
                    ht = -ht;
                end

                h(r,c) = h(r,c) + ht * alphas(1,t);
            end
        end
    end

end

