
% p1 = [
%   1 1  2 2 5 9;
%   1 2  2 1 5 9;
%   1 1  1 1 1 1
% ];
% 
% 
% p2 = [
%   3 0  0 -3 5 4;
%   0 3  -3 0 5 4;
%   1 1  1 1 1 1
% ];

p1 = [
  1 1  2 2 5 1.5 9 4;
  1 2  2 1 5 1.5 4 7;
  1 1  1 1 1 1 1 1
];


p2 = [
  3 0  0 -3 6 0 4 8;
  0 3  -3 0 8 0 6 4;
  1 1  1 1 1 1 1 1
];


mat = [
    2 2 2;
    1 2 0;
    5 0 1
];

p2 = mat*p1;



% function [ H ] = doRansac( p1,p2, s, t, T, N)
%DORANSAC Summary of this function goes here
%   Detailed explanation goes here
%   p1: points in img1
%   p2: points in img2
%   s: number of points regarded at a time
%   t: threshold for distance
%   T: threshold for number of inliers
%   N: max-iterations


H = doRansac(p1,p2,4,1,5,2000);


% H = doDLT(p1,p2);

calcP2 = zeros(size(p1));

calcP2 = H*p1;


calcP2 = normalizePoints(calcP2);