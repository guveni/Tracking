% reading the image

I=imread('imagesequence/img1.ppm');
I = double(rgb2gray(I)) ;

[sY sX] = size(I);

angle = 50 / 180 * pi;
scaleX = 1;
scaleY = 2;

H2 = [2 0 0; 
      0 2 0; 
      0 0 1];
 
H2 = [.1 1 0; 
      -1 1 0; 
      0 0 1];
 
  H0 = [cos(angle) sin(angle) 0;
       -sin(angle) cos(angle) 0;
        0               0     1]; 

H1 = [scaleX 0 0;
       0     scaleY 0;
       0 0 1;];
    
  
 H2 = H0 * H1;
   
tform = maketform('affine',H2);
[WARP,xdata,ydata] = imtransform(I,tform);

tform2 = maketform('affine',inv(H2));
[WARP2,xdata,ydata] = imtransform(WARP,tform2);

[WARP] = warpNew(I,H2);

[swY swX] = size(WARP);

p2 = [swX/2;swY/2;1];
p2 = [400;400;1];

p1 = calcPointAfterWarping(p2,size(I),size(WARP),H2,1);


p11 = [sX/2;1;1];

p22 = calcPointAfterWarping(p11,size(I),size(WARP),H2,0);

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

figure(3);
imshow(WARP2,[0 255]);

