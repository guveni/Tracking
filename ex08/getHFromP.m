function [ H ] = getHFromP( p,rect )
%GETHFROMP Summary of this function goes here
%   Detailed explanation goes here
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


    transA = p(1:2); 
    transB = p(3:4); 
    transC = p(5:6); 
    transD = p(7:8); 

    At = A + [transA;0];
    Bt = B + [transB;0];
    Ct = C + [transC;0];
    Dt = D + [transD;0];

    H = doDLT([A B C D], [At Bt Ct Dt]);
end

