function [ output_args ] = warpRectangle( img, rect )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[rows, cols] = size(img);

%rect looks like this: [x, y, width, height]'
x = rect(1);
y = rect(2);
width = rect(3);
height = rect(4);

%the corners of the rectangle
A = [x;y];
B = [x+width;y];
C = [x;y+height];
D = [x+width;y+height];

%constructing the grid
grid = zeros(rows, cols);

for i = 1:5:rows
    for j = 1:5:cols
        
        grid(i, j) = 1;
    end
end

% warpCount >= number of grid points
warpCount = 20;

randStart = -10;
randEnd = 10;
randRange = randEnd-randStart+1;
randStart = randStart-0.5;

for i = 1:warpCount
    
    %these will be the random transformations for the rectangle corners
    
    transA = round(rand(2, 1)*randRange+randStart); 
    transB = round(rand(2, 1)*randRange+randStart); 
    transC = round(rand(2, 1)*randRange+randStart); 
    transD = round(rand(2, 1)*randRange+randStart); 
    
    At = A * transA;
    Bt = B * transB;
    Ct = C * transC;
    Dt = D * transD;
    
    %doDLT
    H = doDLT([A B C D], [At Bt Ct Dt]);
    invH = inv(H);
    
    %backwarp
    Ab = A * invH;
    Bb = B * invH;
    Cb = C * invH;
    Db = D * invH;
    
   
    %normalize intensity values (mean = 0, standard deviation = 1)
    %add some random noise to intensity values
    
    
end

end

