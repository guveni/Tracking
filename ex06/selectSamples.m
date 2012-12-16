function [ pos ] = selectSamples( nSelect,nAll )
%SELECTSAMPLES chooses nSelect different numbers that are less or equal
%nAll

    list = linspace(1,nAll,nAll);
    pos = zeros(1,nSelect);
    
    for i=1:nSelect
        r = randi(size(list));
        pos(i) = list(r);
        list(r) = [];
    end
    

end

