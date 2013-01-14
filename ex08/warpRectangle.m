function [ output_args ] = warpRectangle( img, rect )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%rect looks like this: [x, y, width, height]'
x = rect(1);
y = rect(2);
width = rect(3);
height = rect(4);
xx = x + width;
yy = y + height;

grid = [1:5:width; 1:5:height];

warpCount = 20; % >= number of grid points

for i = 1:warpCount
    
    trans = round(rand(2, 1)*5); %this will be the random transformation for the x- and y-coordinates
    xN = x * trans;
    xxN = xx * trans;
    yN = y * trans;
    yyN = yy * trans;
    
    %doDLT
    %backwarp
    %normalize intensity values (mean = 0, standard deviation = 1)
    %add some random noise to intensity values
    
    
end

end

