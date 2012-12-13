% reading the image

I=imread('imagesequence/img1.ppm');
I = double(rgb2gray(I)) ;

[sY sX] = size(I);

H2 = [1 1 0; 
      -1 1.0 0; 
      0 0 1];
%  
% H2 = [.5 .5 0; 
%       -.5 .5 0; 
%       0 0 1];
 


tform = maketform('affine',H2);
[WARP,xdata,ydata] = imtransform(I,tform);

[swY swX] = size(WARP);
% 
% p1 = [25;50;1];
% p1rel = p1 - [sX/2;sY/2;0];
% 
% p2rel = inv(H2) * p1rel;
% p2 = p2rel + [swX;swY;0];

%p2rel = inv(H2) * [-400;-320;1];

p2 = [swX/2;swY/2;1];
p2 = [400;400;1];
p2rel = p2 - [swX/2;swY/2;0];

p1rel = H2 * p2rel;
p1 = p1rel + [sX/2;sY/2;0];

p11 = [sX/2;1;1];
% p11 = [1;1;1];
p11rel = p11 - [sX/2;sY/2;0];

p22rel = (H2) \ p11rel;
p22 = p22rel + [swX/2;swY/2;0];

center = [sX/2,sY/2];
figure(1);
imshow(I,[0 255]);
hold on;
plot([center(1),p1(1)],[center(2),p1(2)],'-xr');
plot([center(1),p11(1)],[center(2),p11(2)],'-xy');
plot(sX/2,sY/2,'og');
hold off;

centerW = [swX/2,swY/2];
figure(2);
imshow(WARP,[0 255]);
hold on;
plot([centerW(1),p2(1)],[centerW(2),p2(2)],'-xr');
plot([centerW(1),p22(1)],[centerW(2),p22(2)],'-xy');
plot(p22(1),p22(2),'xy');
plot(swX/2,swY/2,'og');
hold off;



