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
