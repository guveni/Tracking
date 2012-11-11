function [ Ix ] = derivateX( img )
%DERIVATEX derivates the image in X-direction
%   img: input-image
%   Ix: derivate of img

[R C] = size(img);

Ix = zeros(R,C);

Ix(:,1:C-1) = img(:,2:C) - img(:,1:C-1);


end
