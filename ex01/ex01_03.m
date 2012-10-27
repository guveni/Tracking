%function [ output_args ] = ex01_03( input_args )
%EX01_03 Summary of this function goes here
%   Detailed explanation goes here

im = imread('lena.gif');
treatment = 1;

Dx = [-1,0,1;-1,0,1;-1,0,1];
Dy = [-1,-1,-1;0,0,0;1,1,1];

%'Ex 3 - a : gradient X direction'
resDx = convolute(im,Dx,treatment);

%'Ex 3 - a : gradient Y direction'
resDy = convolute(im,Dy,treatment);

% ex 3 - b : gradient magnitude
real_gradient_mag =  sqrt(resDx.^2+resDy.^2);
% real_gradient_mag =real(gradient_mag);

% ex 3 - b : gradient orientation
% according to exercise-sheet:
% atan(resDy./resDx);
% but we do 360° angle
gradient_ori = atan2(resDy,resDx);

% ex 3 - c
sigma = 1;
gaussian1dCol = getGaussian1d(sigma);
gaussian1dRow = transpose(gaussian1dCol);

gx = convolute(Dx,gaussian1dRow,treatment);
gy = convolute(Dy,gaussian1dCol,treatment);

resDx = convolute(im,gx,treatment);

%'Ex 3 - a : gradient Y direction'
resDy = convolute(im,gy,treatment);

real_gradient_mag_2 =  sqrt(resDx.^2+resDy.^2);
%real_gradient_mag_2 =real(gradient_mag);

subplot(1,3,1); 
imshow(real_gradient_mag,[0 500]); 
title('gradient magnititude');

subplot(1,3,2); 
imshow(gradient_ori,[-pi/2 pi/2]); 
colormap('jet');
title('gradient orientation');

subplot(1,3,3); 
imshow(real_gradient_mag_2,[0 500]); 
title('result');

figure();
imshow(gradient_ori,[-pi pi]);
colormap('jet');

%end

