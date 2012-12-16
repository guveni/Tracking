function [ matches ] = Untitled( img, framesT0, descriptorsT0)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    [frames,descriptors] = vl_sift(single(rgb2gray(img))) ;
    
    matches = vl_ubcmatch(descriptors, descriptorsT0) ;

end

