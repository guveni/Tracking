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

figure();

for i = 1:3

    harrisPoints = applyMultiscaleHarris(img,s0,k,n(i),alpha,t,nonMaxSupprRadius);

    [x_p,y_p] = find(harrisPoints);
    subplot(1,3,i);
    imshow(img, [0, 255]);
    hold on;
    plot(y_p,x_p,'x');
    hold off;
    title(sprintf('harris %d',n(i)));
end




