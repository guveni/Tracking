function [ rotationMat, translationMat ] = getRotationTranslationMat( x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

  
  rx = x(1,1);
  ry = x(2,1);
  rz = x(3,1);
  tx = x(4,1);
  ty = x(5,1);
  tz = x(6,1);
  
  rx = rx/180*pi;
  ry = ry/180*pi;
  rz = rz/180*pi;
  
  Rx = [
      1        0        0  0;
      0  cos(rx) -sin(rx)  0;
      0  sin(rx)  cos(rx)  0;
      0        0        0  1;
  ];


  Ry = [
      cos(ry)       0   sin(ry)  0;
            0       1        0   0;
     -sin(ry)       0   cos(ry)  0;
            0       0         0  1;
  ];

  Rz = [
      cos(rz) -sin(rz)         0   0;
      sin(rz)  cos(rz)         0   0;
            0        0         1   0;
            0        0         0   1;
  ];

  rotationMat = Rz*(Ry*Rx);

  translationMat = [
      1 0 0 tx;
      0 1 0 ty;
      0 0 1 tz;
      0 0 0  1;
  ];

end

