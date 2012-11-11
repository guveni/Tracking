img =  imread('harris.jpg');
img = rgb2gray(img);

img = double(img);

R = computeResponse(img);

% matrix containing 1 for all fields where R > 1000
threshold = (R>1000);

localMaxima = findLocalMaxima(R,3);

localMaxima = localMaxima.*threshold;

subplot(1,3,1); 
imshow(R,[-3000,3000]);
title('R');

subplot(1,3,2); 
imshow(threshold,[0,1]);
title('threshold');


subplot(1,3,3); 
imshow(localMaxima,[0,1]);
title('local maxima');


