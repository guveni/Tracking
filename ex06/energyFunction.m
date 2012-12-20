function [ energy ] = energyFunction( A,x,M,m )
%ENERGYFUNCTION Summary of this function goes here
%   Detailed explanation goes here

  

  A = [A [0;0;0]];
  A = [A;0 0 0 1];

  [R, T] = getRotationTranslationMat(x);
    
  mTilde = A*R*T*M;

  normalizePoints(mTilde);
  normalizePoints(m);
  
  energy = 0;
  for i=1:size(M,2)
     energy = energy + (norm(mTilde(1:3,i)-m(1:3,i)))^2;
  end


end

