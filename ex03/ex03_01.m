img =  imread('lena.gif');

 img = imread('harris.jpg');
 img = rgb2gray(img);

img = double(img);

s0 = 1.5;
k = 1.2;
n = [0 5 17];
alpha = 0.06;
t = 50;
nonMaxSupprRadius = 1;

for i = 1:3

    harrisPoints = applyMultiscaleHarris(img,s0,k,n(i),alpha,t,nonMaxSupprRadius);


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




