clear;
close all;

img1rgb = double(imread('./sequence/2043_000140.jpeg'));
img1hsv = rgb2hsv(img1rgb);


rect = [506, 308, 49, 38];
x = rect(1);
y = rect(2);
width = rect(3);
height = rect(4);

figure(2);
imshow(img1rgb/255);
hold on;
plot([x, x+width, x+width, x, x], [y, y, y+height, y+height, y], '-r');
hold off;

regionHsv = img1hsv(y:y+height,x:x+width, :);
regionRgb = img1rgb(y:y+height,x:x+width, :);
figure(1);
histogram = colorHist(regionHsv);
bar(1:256, histogram);

% normalize histogram
histogram = histogram/sum(histogram)*255;

figure(5);
imshow(regionRgb/255);


probDist = probMap(img1hsv,histogram);

figure(6);
imshow(probDist,[0 255]);


for imgId=140:190
    filename = sprintf('./sequence/2043_000%d.jpeg', imgId);
    imgRgb = double(imread(filename));
    imgHsv = rgb2hsv(imgRgb);
    
    probDist = probMap(imgHsv,histogram);
    figure(7);
    subplot(1, 2, 1);
    imshow(imgRgb/255);
    subplot(1,2,2);
    imshow(probDist,[0,255]);
end





