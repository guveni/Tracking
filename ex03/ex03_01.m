img =  imread('lena.gif');

img = imread('harris.jpg');
img = rgb2gray(img);

img = double(img);

s0 = 1.5;
k = 1.2;
n = [0 5 17];
alpha = 0.04;
t = 500;
nonMaxSupprRadius = 1;

for i = 1:3

    % localMaxima = applyMultiscaleHarris(img,s0,k,n(i),alpha,t,nonMaxSupprRadius);

    R = computeResponse(img,s0,k,n(i),0.04);

    % matrix containing 1 for all fields where R > 1000
    threshold = (R>t);

    localMaxima = findLocalMaxima(R,nonMaxSupprRadius);

    harrisPoints = localMaxima.*threshold;
 
    subplot(1,3,i);
    imshow(harrisPoints,[0,1]);
    title(sprintf('harris %d',n(i)));
    
%     subplot(3,3,3*i-2); 
%     imshow(R,[0,4000]);
%     title(sprintf('R %d',n(i)));
%  
%     subplot(3,3,3*i-1); 
%     imshow(threshold,[0,1]);
%     title(sprintf('t %d',n(i)));
%     
%     subplot(3,3,3*i);
%     imshow(harrisPoints,[0,1]);
%     title(sprintf('h %d',n(i)));

end




