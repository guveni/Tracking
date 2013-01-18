clear;
close all;

img1rgb = double(imread('./sequence/2043_000140.jpeg'));


rect = [506, 308, 49, 38];
x = rect(1);
y = rect(2);
width = rect(3);
height = rect(4);

region = img1rgb(x:x+width, y:y+height, :);
figure(1);
histogram = colorHist(region);
bar( histogram);


figure(2);
imshow(img1rgb/255);
hold on;
plot([x, x+width, x+width, x, x], [y, y, y+height, y+height, y], '-r');
hold off;


