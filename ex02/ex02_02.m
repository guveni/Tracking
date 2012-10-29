img = imread('lena.gif');



imgNeu = applyBilateralFilter(img,1,1);

figure();
imshow(imgNeu,[0 255]);