clear;
close all;

d = load('data1.mat');
dat1 = d.dat;
d = load('data2.mat');
dat1 = d.dat;
d = load('data3.mat');
dat1 = d.dat;

figure(1);
hold on;
for i=1:size(dat1,1)
   if( dat1(i,3) == 1)
       plot(dat1(i,1),dat1(i,2),'bx')
   else
       plot(dat1(i,1),dat1(i,2),'rx')
   end
end
hold off;


T = 1000; % number of iterations/weak classifiers
numSamples = size(dat1,1);

w = zeros(T+1,numSamples); 
% weights
% one line for each itereation
% one column for each sample-point

w(1,:) = ones(1,numSamples)/numSamples;

h = zeros(T,3);
% weak classifiers
% one row for each iteration
% three columns per classifier: 
%   first indicates if horizontal (1) or vertical (2)
%   second is for the position on the axis
%   third is 1 if positive samples are above/right of the line, 2 otherwise
% e.g. (1 20) means a horizontal line crossing the Y-axis at y=20

alphas = zeros(1,T);
betas = zeros(1,T);

for t=1:T
    
    % find best classifier
    
    [h1 h2 h3 error correctOnes] = findBestClassifier(dat1,w(t,:));
    
    h(t,:) = [h1 h2 h3];
    beta = error/(1-error);
    betas(1,t) = beta;
    alphas(1,t) = -log(beta);
    
    
    w(t+1,:) = w(t,:) .* ( (beta.*ones(1,numSamples)) .^ (correctOnes==1) );
    
    
    % normalize weights (so that sum = 1)
    w(t+1,:) = w(t+1,:) ./ sum(w(t+1,:));
    
end


minX = min(dat1(:,1));
maxX = max(dat1(:,1));
minY = min(dat1(:,2));
maxY = max(dat1(:,2));

[X,Y] = meshgrid(minX:maxX,minY:maxY); 
out = getHypothesis(h,alphas,X,Y);


figure();
mesh(X,Y,out)








% figure(2);
% hold on;
% for i=1:size(dat2,1)
%    if( dat2(i,3) == 1)
%        plot(dat2(i,1),dat2(i,2),'bx')
%    else
%        plot(dat2(i,1),dat2(i,2),'rx')
%    end
% end
% hold off;
% 
% figure(3);
% hold on;
% for i=1:size(dat3,1)
%    if( dat3(i,3) == 1)
%        plot(dat3(i,1),dat3(i,2),'bx')
%    else
%        plot(dat3(i,1),dat3(i,2),'rx')
%    end
% end
% hold off;

