function [ list ] = getRandomPositions( n,range )
%GETRANDOMPOSITIONS Summary of this function goes here
%   Detailed explanation goes here

    
    % generate numbers between -range and range with size [2,n]
    list = randi([-range,range],[2,n]);
end



