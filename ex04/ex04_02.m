
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

p2(:,1:4) = mat*p1(:,1:4);
p2 = normalizePoints(p2);



s = 4;
t = 1;
T = 7;
N = 2000;

% function [ H ] = doRansac( p1,p2, s, t, T, N)
%DORANSAC Summary of this function goes here
%   Detailed explanation goes here
%   p1: points in img1
%   p2: points in img2
%   s: number of points regarded at a time
%   t: threshold for distance
%   T: threshold for number of inliers
%   N: max-iterations
[H,cons] = doRansac(p1,p2,s,t,T,N);

p = 0.99;
%   p1: points in img1
%   p2: points in img2
%   s: number of points regarded at a time (minimum count of points for DLT is 4)
%   t: threshold for distance
%   p: probability to have best solution

[H,cons]=doAdaptiveRansac(p1,p2,s,t,p);


calcP2 = H*p1;


calcP2 = normalizePoints(calcP2);


figure()

h1 = plot(p2(1,:),p2(2,:),'om','MarkerSize',5);    %# Plot line 1

hold on;
h2 = plot(calcP2(1,:),calcP2(2,:),'ob','MarkerSize',5);  %# Plot line 2


for i = 1:size(p2,2)
    if any(cons==i)
        plot([calcP2(1,i) p2(1,i)],[calcP2(2,i) p2(2,i)],'-g');  %# Plot line 2
    else
        plot([calcP2(1,i) p2(1,i)],[calcP2(2,i) p2(2,i)],'-r');  %# Plot line 2
    end
    
end

