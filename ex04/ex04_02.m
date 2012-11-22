close all;


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

p2(:,1:5) = mat*p1(:,1:5);
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

% [H,cons,tmp,Hbest] = doRansac(p1,p2,s,t,T,N);

p = 0.999;
%   p1: points in img1
%   p2: points in img2
%   s: number of points regarded at a time (minimum count of points for DLT is 4)
%   t: threshold for distance
%   p: probability to have best solution

[H,cons,tmp,Hbest]=doAdaptiveRansac(p1,p2,s,t,p);


 % only H and cons are required
 % other parameters are only for debugging: tmp = samples that were used
 % for iteration with best consens
 % Hbest = transformation calculated on samples with best consens
 % H = transformation calculated for all points in consens
 
calcP2 = H*p1;
calcP22 = Hbest*p1;

calcP2 = normalizePoints(calcP2);
calcP22 = normalizePoints(calcP22);


figure(1)

h1 = plot(p2(1,:),p2(2,:),'xm','MarkerSize',5);    %# Plot line 1

hold on;
h2 = plot(calcP2(1,:),calcP2(2,:),'ob','MarkerSize',5);  %# Plot line 2
h3 = plot(calcP22(1,:),calcP22(2,:),'oc','MarkerSize',5);  %# Plot line 2

dst1=0;
for i = 1:size(p2,2)
    if any(cons==i)
        plot([calcP2(1,i) p2(1,i)],[calcP2(2,i) p2(2,i)],'-g');  %# Plot line 2
        dst1 = dst1+norm( p2(:,i)-calcP2(:,i));
    else
        plot([calcP2(1,i) p2(1,i)],[calcP2(2,i) p2(2,i)],'-r');  %# Plot line 2
    end
    
end


figure(2)

h1 = plot(p2(1,:),p2(2,:),'xm','MarkerSize',5);    %# Plot line 1

hold on;
h2 = plot(calcP2(1,:),calcP2(2,:),'ob','MarkerSize',5);  %# Plot line 2
h3 = plot(calcP22(1,:),calcP22(2,:),'oc','MarkerSize',5);  %# Plot line 2

dst2=0;
for i = 1:size(p2,2)
    if any(cons==i)
        plot([calcP22(1,i) p2(1,i)],[calcP22(2,i) p2(2,i)],'-g');  %# Plot line 2
        dst2 = dst2+norm( p2(:,i)-calcP22(:,i));
    else
        plot([calcP22(1,i) p2(1,i)],[calcP22(2,i) p2(2,i)],'-r');  %# Plot line 2
    end
    
end





