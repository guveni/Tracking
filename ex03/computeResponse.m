function [ R ] = computeResponse( img,sigmaD,sigmaI,alpha )
%BUILDM creates matrix M


filter = fspecial('gaussian',3*sigmaD,sigmaD);
img = imfilter(img,filter,'conv');

Ix = derivateX(img);
Iy = derivateY(img);

Ixx = Ix.*Ix;
Iyy = Iy.*Iy;
Ixy = Ix.*Iy;

filter = fspecial('gaussian',3*sigmaI,sigmaI);
Ixx = imfilter(Ixx,filter,'conv');
Iyy = imfilter(Iyy,filter,'conv');
Ixy = imfilter(Ixy,filter,'conv');

det = Ixx.*Iyy-Ixy.*Ixy;
trace = Ixx+Iyy;

R = det - alpha * trace.^2;

end

