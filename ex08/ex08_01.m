close all;
clear;

img = double(rgb2gray(imread('image_sequence/0000.png')));

rectangle = [200;120;200;200];
left = rectangle(1);
right = rectangle(1)+rectangle(3);
top = rectangle(2);
bottom = rectangle(2)+rectangle(4);


figure(1);
imshow(img,[0 255]);
hold on;
plot([left right right left left],[top top bottom bottom top],'r-');

warpImg = warpRectangle(img,rectangle);

figure(2);
imshow(warpImg,[-128 128]);

