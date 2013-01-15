function [ normImg ] = normalizeImage( img )
%NORMALIZEIMAGE normalize the image according to the ex-sheet
%   img: image-matrix

    pixSum = sum(sum(img));
    normImg = img-pixSum;
end

