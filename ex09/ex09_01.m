img1 = imread('./sequence/2043_000140.jpeg');

rect = [100, 100, 100, 100];
x = rect(1);
y = rect(2);
width = rect(3);
height = rect(4);

region = img1(x:x+width, y:y+height, :);
histogram = colorHist(region);
bar(0:255, histogram);


% hold on;
% plot([x, x+width, x+width, x, x], [y, y, y+height, y+height, y], '-r');
% hold off;
% figure(2);

% imshow(region);