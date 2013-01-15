function [ warpImg ] = warpRectangle( img, rect )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[rows, cols] = size(img);

%rect looks like this: [x, y, width, height]'
x = rect(1);
y = rect(2);
width = rect(3);
height = rect(4);

%the corners of the rectangle
A = [x;y;1];
B = [x+width;y;1];
C = [x;y+height;1];
D = [x+width;y+height;1];


randStart = -10;
randEnd = 10;
randRange = randEnd-randStart+1;
randStart = randStart-0.5;

%these will be the random transformations for the rectangle corners

transA = round(rand(2, 1)*randRange+randStart); 
transB = round(rand(2, 1)*randRange+randStart); 
transC = round(rand(2, 1)*randRange+randStart); 
transD = round(rand(2, 1)*randRange+randStart); 

At = A + [transA;0];
Bt = B + [transB;0];
Ct = C + [transC;0];
Dt = D + [transD;0];

%doDLT
H = doDLT([A B C D], [At Bt Ct Dt]);
invH = inv(H);

%backwarp
Ab = normalizePoints(H\At);
Bb = normalizePoints(H\Bt);
Cb = normalizePoints(H\Ct);
Db = normalizePoints(H\Dt);

newRows = rows+randRange;
newCols = cols+randRange;
warpImg = ones(newRows,newCols)*-1;

pixSum = 0;

for r=1:newRows
    for c=1:newCols
        % simple nearest neighbour matching
        oriPos = round( normalizePoints(H\[c;r;1]) );
        
        if oriPos(1) > 0 && oriPos(1) <= cols && oriPos(2) > 0 && oriPos(2) <= rows
            intensity = img(oriPos(2),oriPos(1));
            warpImg(r,c) =  intensity;

        else
            warpImg(r,c) = NaN;
        end
    end
end

meanVal = mean( warpImg( ~isnan(warpImg) ) );
warpImg = warpImg - meanVal;

% stdDev = std( warpImg (~isnan(warpImg) ) );
% warpImg = warpImg / stdDev;

%normalize intensity values (mean = 0, standard deviation = 1)
%add some random noise to intensity values
    
    
end

