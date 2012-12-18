function [ energy ] = energyFunction( A,x,M,m )
%ENERGYFUNCTION Summary of this function goes here
%   Detailed explanation goes here

  M(4,:) = ones(1,size(M,2));

  A = [A [0;0;0]];
  A = [A;0 0 0 1];

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

%   Rz = [
%       cos(rz) -sin(rz)   sin(rz)   0;
%      -sin(rz)  cos(rz)         0   0;
%             0        0         1   0;
%             0        0         0   1;
%   ];
  Rz = [
      cos(rz) -sin(rz)         0   0;
      sin(rz)  cos(rz)         0   0;
            0        0         1   0;
            0        0         0   1;
  ];

  R = Rz*(Ry*Rx);

  T = [
      1 0 0 tx;
      0 1 0 ty;
      0 0 1 tz;
      0 0 0  1;
  ];
  
  mTilde = A*R*T*M;

  normalizePoints(mTilde);
  normalizePoints(m);
  
  energy = 0;
  for i=1:size(M,2)
     energy = energy + norm(mTilde(1:2,i)-m(1:2,i))^2;
  end


end

