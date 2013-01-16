close all;
clear;

img = double(rgb2gray(imread('image_sequence/0000.png')));

rectangle = [250;150;100;100];
left = rectangle(1);
right = rectangle(1)+rectangle(3);
top = rectangle(2);
bottom = rectangle(2)+rectangle(4);

width = right-left;
height = bottom-top;

numGridPoints = 10;

stepX = width/(numGridPoints-1);
stepY = height/(numGridPoints-1);

[gridX,gridY] = meshgrid(1:stepX:width+1,1:stepY:height+1);

gridX = gridX +left-1;
gridY = gridY +top-1;
figure(1);
imshow(img,[0 255]);
hold on;
plot([left right right left left],[top top bottom bottom top],'r-');
plot(gridX,gridY,'bo');

warpImg = warpRectangle(img,rectangle,gridX,gridY);

figure(2);
imshow(warpImg,[-2 2]);

