function [ H ] = doDLT( refPoints, corPoints )
%DODLR calculate homography using DLT
%   refPoints: position of points in reference image (x)
%   corPonts: position of points in correspondence image (x')
%   H: homography
    

    % number of points
    N = size(refPoints,2);

    if(size(corPoints,2) ~= N)
        disp('the inputs do not contain the same number of values');
    end
           
    % normalize points (this means points have form x,y,1)
    refPoints = normalizePoints(refPoints);
    corPoints = normalizePoints(corPoints);
    
    % get matrix that transform points so that center of points is in
    % origin and average distance from origin is 1
    U = getNormalizedTransform(refPoints);
    T = getNormalizedTransform(corPoints);
        
    refPoints = U*refPoints;
    corPoints = T*corPoints;
    
    % matrix A for    Ax=0
    A = zeros(2*N,9);
    A = [];

    %build matrix A
    for i=1:N
        xC = corPoints(1,i);
        yC = corPoints(2,i);
        
        pR = refPoints(:,i);
        
        A(i*2-1,:) = [ 0, 0, 0, -pR', yC*pR' ];
        A(i*2,:)   = [ pR', 0, 0, 0, -xC*pR'  ];
        
    end
    
    % do single value decomposition
    [u,d,v] = svd(A);
    
    % build a matrix from last column of v
    % v1 v2 v3
    % v4 v5 v6
    % v7 v8 v9
    Ht = reshape(v(:,9),3,3)';
    % Ht = Ht / Ht(end,end);
    
    H = inv(T)*Ht*U;
    % H = H / H(end,end);
end
