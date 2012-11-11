function [ R ] = computeResponse( img,s0,k,n,alpha )
%BUILDM creates matrix M

    sigmaI = s0*k^n;
    sigmaD = 0.7*sigmaI;

    filter = fspecial('gaussian',floor(3*sigmaD),sigmaD);
    img = imfilter(img,filter,'conv');

    Ix = derivateX(img);
    Iy = derivateY(img);

    Ixx = Ix.*Ix;
    Iyy = Iy.*Iy;
    Ixy = Ix.*Iy;

    filter = fspecial('gaussian',floor(3*sigmaI),sigmaI);
    filter = sigmaD^2*filter;

    Ixx = imfilter(Ixx,filter,'conv');
    Iyy = imfilter(Iyy,filter,'conv');
    Ixy = imfilter(Ixy,filter,'conv');

    det = Ixx.*Iyy-Ixy.*Ixy;
    trace = Ixx+Iyy;

    R = det - alpha * trace.^2;

end

