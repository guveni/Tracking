

I_1 = imread('tum_mi_1.JPG') ;
%I = imread('tum_mi_2.JPG') ;
% I1 = single(rgb2gray(I_1)) ;
[frames1,descriptors1] = vl_sift(single(rgb2gray(I_1))) ;

I_2 = imread('tum_mi_2.JPG') ;
% I2 = single(rgb2gray(I_2)) ;
[frames2,descriptors2] = vl_sift(single(rgb2gray(I_2))) ;

matches = vl_ubcmatch(descriptors1, descriptors2) ;


p1 = frames1(1:2,matches(1,:));

% write ones to third line (normalized vectors)
p1(3,:) = ones(1,size(p1,2));

p2 = frames2(1:2,matches(2,:));

% write ones to third line (normalized vectors)
p2(3,:) = ones(1,size(p2,2));

[H,cons,tmp,Hbest]=doAdaptiveRansac(p1,p2,4,0.5,0.999999);
%[H,cons,tmp,Hbest]=doRansac(p1,p2,4,0.5,100,10000);
%H=Hbest;

[h1,w1,d] = size(I_1);
[h2,w2,d] = size(I_2);

% I1 = I_1;
% I2 = I_2;
box2 = [1  w2 w2  1 ;
        1   1 h2 h2 ;
        1   1  1  1 ] ;
    
% calc bounding box around warped image
bb = inv(H) * box2;

rangeC = min([1 bb(1,:)./bb(3,:)]):max([w1 bb(1,:)./bb(3,:)]);
rangeR = min([1 bb(2,:)./bb(3,:)]):max([h1 bb(2,:)./bb(3,:)]);

% get all points in the box to which the image will be translated and
% calculate their color by doing backwards warping

[u,v] = meshgrid(rangeC,rangeR) ;
warp1 = vl_imwbackward(im2double(I_1),u,v) ;

z = H(3,1) * u + H(3,2) * v + H(3,3) ;
x = (H(1,1) * u + H(1,2) * v + H(1,3)) ./ z ;
y = (H(2,1) * u + H(2,2) * v + H(2,3)) ./ z ;

warp2 = vl_imwbackward(im2double(I_2),x,y) ;


mosaic = zeros(size(warp1));
for r = 1:size(warp1,1)
    for c = 1:size(warp1,2)
        for d = 1:3
            validColors = 0;
            
            c1 = warp1(r,c,d);
            c2 = warp2(r,c,d);
            
            if isnan(c1)
                c1 = 0;
            else
                validColors = validColors+1;
            end
            
             if isnan(c2)
                c2 = 0;
            else
                validColors = validColors+1;
             end
            
             mosaic(r,c,d) = (c1+c2) / validColors;
        end
    end
end



figure(2) ;
imagesc(mosaic) ; axis image off ;
title('Mosaic') ;






% corners = [
% 0 0 w w;
% 0 h 0 h;
% 1 1 1 1
% ];
% 
% cornersTranslated = inv(H)*corners;
% 
% left = min(cornersTranslated(1,:));
% right = max(cornersTranslated(1,:));
% 
% top = min(cornersTranslated(2,:));
% bottom = max(cornersTranslated(2,:));
% 
% calcP2 = H*p1;
% calcP22 = Hbest*p1;
% 
% calcP2 = normalizePoints(calcP2);
% calcP22 = normalizePoints(calcP22);


% figure(1)
% imshow(I_1);
% 
% hold on;
% h1 = plot(p1(1,:),p1(2,:),'xm','MarkerSize',5);    %# Plot line 1


% h2 = plot(calcP2(1,:),calcP2(2,:),'ob','MarkerSize',5);  %# Plot line 2
% h3 = plot(calcP22(1,:),calcP22(2,:),'oc','MarkerSize',5);  %# Plot line 2
% 
% dst1=0;
% for i = 1:size(p2,2)
%     if any(cons==i)
%         plot([calcP2(1,i) p2(1,i)],[calcP2(2,i) p2(2,i)],'-g');  %# Plot line 2
%         dst1 = dst1+norm( p2(:,i)-calcP2(:,i));
%     else
%         plot([calcP2(1,i) p2(1,i)],[calcP2(2,i) p2(2,i)],'-r');  %# Plot line 2
%     end
%     
% end



% figure(2)
% imshow(I_2);
% 
% hold on;
% h1 = plot(calcP2(1,:),calcP2(2,:),'xm','MarkerSize',5);    %# Plot line 1
% h1 = plot(p2(1,:),p2(2,:),'or','MarkerSize',5);    %# Plot line 1

% 
% h2 = plot(calcP2(1,:),calcP2(2,:),'ob','MarkerSize',5);  %# Plot line 2
% h3 = plot(calcP22(1,:),calcP22(2,:),'oc','MarkerSize',5);  %# Plot line 2
% 
% dst1=0;
% for i = 1:size(p2,2)
%     if any(cons==i)
%         plot([calcP2(1,i) p2(1,i)],[calcP2(2,i) p2(2,i)],'-g');  %# Plot line 2
%         dst1 = dst1+norm( p2(:,i)-calcP2(:,i));
%     else
%         plot([calcP2(1,i) p2(1,i)],[calcP2(2,i) p2(2,i)],'-r');  %# Plot line 2
%     end
%     
% end
