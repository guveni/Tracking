clear;
close all;

img1rgb = double(imread('./sequence/2043_000140.jpeg'));
img1hsv = rgb2hsv(img1rgb);

rect = [506, 308, 49, 38];
x = rect(1);
y = rect(2);
width = rect(3)-1;
height = rect(4)-1;

figure(1);
imshow(img1rgb/255);
hold on;
plot([x, x+width, x+width, x, x], [y, y, y+height, y+height, y], '-r');
hold off;

regionHsv = img1hsv(y:y+height,x:x+width, :);
regionRgb = img1rgb(y:y+height,x:x+width, :);
figure(2);
histogram = colorHist(regionHsv);
bar(1:256, histogram);

% normalize histogram
histogram = histogram/sum(histogram)*255;

centerX = x+width/2;
centerY = y+height/2;
oldCenterX = centerX;
oldCenterY = centerY;

for imgId=140:190

    filename = sprintf('./sequence/2043_000%d.jpeg', imgId);
    imgRgb = double(imread(filename));
    imgHsv = rgb2hsv(imgRgb);
    figure(3);
    imshow(imgRgb/255);
    hold on;
    
    ctr = 1;
    while ctr < 20
        
       le = round(centerX-width/2);
       ri = round(centerX+width/2);
       to = round(centerY-height/2);
       bo = round(centerY+height/2);
       regionHsv = imgHsv(to:bo,le:ri, :);
       probDist = probMap(regionHsv,histogram);
       
       xSum=0;
       ySum=0;

       for r=to:bo
           for c=le:ri
               xSum=xSum+c*probDist(r-to+1,c-le+1);
               ySum=ySum+r*probDist(r-to+1,c-le+1);
               
           end
       end
              
       centerX = xSum/(sum(sum(probDist)));
       centerY = ySum/(sum(sum(probDist)));
       
       if abs(centerX-oldCenterX) < .5 || abs(centerY-oldCenterY) < .5
           le = round(centerX-width/2);
           ri = round(centerX+width/2);
           to = round(centerY-height/2);
           bo = round(centerY+height/2); 
           break;
       end
       
       oldCenterX = centerX;
       oldCenterY = centerY;
       
       plot([le ri ri le le],[to to bo bo to],'b-');
       
       ctr = ctr+1; 
    end

    
    plot([le ri ri le le],[to to bo bo to],'r-');
    hold off;

    
end

