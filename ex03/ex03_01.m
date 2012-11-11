img =  imread('harris.jpg');
img = rgb2gray(img);

img = double(img);

R = computeResponse(img,3,3,0.04);

R = abs(R);

% matrix containing 1 for all fields where R > 1000
threshold = (R>2000);



localMaxima = findLocalMaxima(R,5);

localMaxima = localMaxima.*threshold;

subplot(1,3,1); 
imshow(R,[0,4000]);
title('R');

subplot(1,3,2); 
imshow(threshold,[0,1]);
title('threshold');


subplot(1,3,3); 
imshow(localMaxima,[0,1]);
title('local maxima');


