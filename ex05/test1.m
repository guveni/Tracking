% reading the image

I=imread('imagesequence/img1.ppm');


% I = I(1:20,1:20);
% 
% imshow(I);
H = [3 1 1; 
     -5 2 0; 
     2 3 1];

H2 = [-2 0 0; 
      0 2 0; 
      100 0 1];
 
p1 = [1;1;1];
p2 = [p1(1)-400
p2 = H * p1;



tform = maketform('affine',H2);
[J,xdata,ydata] = imtransform(I,tform);
figure(1);
imshow(I);
hold on;
plot(p1(1),p1(2),'xg');
hold off;
figure(2);
imshow(J,'XData',xdata,'YData',ydata);
hold on;
plot(p2(1)+xdata,p2(2)+ydata,'xg');
hold off;



