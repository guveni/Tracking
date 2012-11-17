function [ Iy ] = derivateY( img )
%DERIVATEY derivates the image in X-direction
%   img: input-image
%   Ix: derivate of img

[R C] = size(img);

Iy = zeros(R,C);

% forward difference
Iy(1:R-1,:) = img(2:R,:) - img(1:R-1,:);

% central difference
% Iy(2:R-1,:) = img(3:R,:) - img(1:R-2,:);


end

