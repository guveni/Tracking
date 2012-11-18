function [ H ] = doDLT( refPoints, corPoints )
%DODLR calculate homography using DLT
%   refPoints: position of points in reference image (x)
%   corPonts: position of points in correspondence image (x')
%   H: homography
    
H = HomoNormDLT(refPoints,corPoints);
return;

    % number of points
    N = size(refPoints,2);

    if(size(corPoints,2) ~= N)
        disp('the inputs do not contain the same number of values');
    end
           
    refPoints = normalizePoints(refPoints);
    corPoints = normalizePoints(corPoints);
    
    U = getNormalizedTransform(refPoints);
    T = getNormalizedTransform(corPoints);
                     
    A = zeros(2*N,9);
    A = [];
    
    refPoints = U*refPoints;
    corPoints = T*corPoints;
    
    %build matrix A
    for i=1:N
        xC = corPoints(1,i);
        yC = corPoints(2,i);
        
        pR = refPoints(:,i);
        
        A(i*2-1,:) = [ 0, 0, 0, -pR', yC*pR' ];
        A(i*2,:)   = [ pR', 0, 0, 0, -xC*pR'  ];
        
    end
    
    [u,d,v] = svd(A);
    
    Ht = reshape(v(:,9),3,3)';
    % Ht = Ht / Ht(end,end);
    
    H = inv(T)*Ht*U;
    % H = H / H(end,end);
end


function H = dlt( x, xp )

  n = size( x, 2 );
  if n < 4
    error( 'DLT requires at least 4 points' );
  end;
  if ( size( x, 1 ) ~= 3 | size( xp, 1 ) ~= 3 )
    error( 'DLT requres homogeneous coordinates' );
  end;

  A = [];

  for i = 1:n

    xip = xp( 1, i );
    yip = xp( 2, i );
    wip = xp( 3, i );

    xi = x( :, i );

    Ai = [ 0, 0, 0,    -wip * xi',   yip * xi' ;
           wip * xi',     0, 0, 0,  -xip * xi' ];

    A = [ A ; Ai ];
  end;

  [U,D,V] = svd( A );

  % In Octave, the SVD is sorted with decreasing singular values
  % so we want the last column of V

  H = reshape( V(:,9), 3, 3 )';
  H = H / H(3,3);
end

%------------------------------------------------------------------------

function H = dlt_norm( x, xp )

  T = normalize_transform( x );
  Tp = normalize_transform( xp );

  Htilde = dlt( T * x, Tp * xp );
  H = inv( Tp ) * Htilde * T;
  H = H / H(3,3);
end

%------------------------------------------------------------------------

function T = normalize_transform( x )

  % Transform taking x's centroid to the origin

  Ttrans = [ 1 0 -mean( x(1,:) ) ; 0 1 -mean( x(2,:) ) ; 0 0 1 ];

  % Calculate appropriate scaling factor

  x = Ttrans * x;
  lengths = sqrt( sum( x(1:2,:).^2 ));
  s = sqrt(2) / mean(lengths);

  % Transform scaling x to an average length of sqrt(2)

  Tscale = [ s 0 0 ; 0 s 0 ; 0 0 1 ];

  % Compose the transforms

  T = Tscale * Ttrans;
end




function H = HomoNormDLT(x1, x2)

[r1,c1] = size(x1);
[r2,c2] = size(x2);

%% centroids of the points
centroid1 = mean(x1(1:2,:)')';
centroid2 = mean(x2(1:2,:)')';

%% Shift the origin of the points to the centroid
x1(1,:) = x1(1,:) - centroid1(1);
x1(2,:) = x1(2,:) - centroid1(2);

x2(1,:) = x2(1,:) - centroid2(1);
x2(2,:) = x2(2,:) - centroid2(2);

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
averagedist1 = mean(sqrt(x1(1,:).^2 + x1(2,:).^2));
averagedist2 = mean(sqrt(x2(1,:).^2 + x2(2,:).^2));

scale1 = sqrt(2)/averagedist1;
scale2 = sqrt(2)/averagedist2;

x1(1:2,:) = scale1*x1(1:2,:);
x2(1:2,:) = scale2*x2(1:2,:);

%% similarity transform 1
T1 = [scale1    0       -scale1*centroid1(1)
      0         scale1  -scale1*centroid1(2)
      0         0       1      ];

%% similarity transform 2
T2 = [scale2    0       -scale2*centroid2(1)
      0         scale2  -scale2*centroid2(2)
      0         0       1      ];

if (c1 == c2)
    A = zeros(2*c1,9);
    
    for n = 1:c1
        x1_x = x1(1,n); x1_y = x1(2,n);
        x2_x = x2(1,n); x2_y = x2(2,n);
        
        A(2*n-1,:) = [x1_x x1_y 1 0 0 0 -x2_x*x1_x -x2_x*x1_y -x2_x];
        A(2*n  ,:) = [0 0 0 x1_x x1_y 1 -x2_y*x1_x -x2_y*x1_y -x2_y];
    end
    
    [U,D,V] = svd(A);
    
    H = reshape(V(:,9),3,3)';
end

%% Denormalization
H = inv(T2)*H*T1;
end


