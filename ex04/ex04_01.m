
refPoints = [
  1 1  2 2;
  1 2  1 2;
  1 1  1 1
];


corPoints = [
  3 0  -3 0;
  0 3  0 -3;
  1 1  1 1
];

H = doDLT(refPoints,corPoints);

calcCorPoints = zeros(size(refPoints));

for i=1:size(refPoints,2);
   calcCorPoints(:,i) = H*refPoints(:,i);
end

calcCorPoints = normalizePoints(calcCorPoints);

