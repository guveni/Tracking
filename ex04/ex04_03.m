

I_1 = imread('tum_mi_1.JPG') ;
%I = imread('tum_mi_2.JPG') ;
I1 = single(rgb2gray(I_1)) ;
[frames1,descriptors1] = vl_sift(I1) ;

I_2 = imread('tum_mi_2.JPG') ;
I2 = single(rgb2gray(I_2)) ;
[frames2,descriptors2] = vl_sift(I2) ;

matches = vl_ubcmatch(descriptors1, descriptors2) ;


p1 = frames1(1:2,matches(1,:));

p1(3,:) = ones(1,size(p1,2));

p2 = frames2(1:2,matches(2,:));
p2(3,:) = ones(1,size(p2,2));

[H,cons,tmp,Hbest]=doAdaptiveRansac(p1,p2,4,10,0.99);
H=Hbest;
[h,w] = size(I1);

corners = [
0 0 w w;
0 h 0 h;
1 1 1 1
];

cornersTranslated = inv(H)*corners;

left = min(cornersTranslated(1,:));
right = max(cornersTranslated(1,:));

top = min(cornersTranslated(2,:));
bottom = max(cornersTranslated(2,:));

calcP2 = H*p1;
calcP22 = Hbest*p1;

calcP2 = normalizePoints(calcP2);
calcP22 = normalizePoints(calcP22);


figure(1)
imshow(I_1);

hold on;
h1 = plot(p1(1,:),p1(2,:),'xm','MarkerSize',5);    %# Plot line 1


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



figure(2)
imshow(I_2);

hold on;
h1 = plot(calcP2(1,:),calcP2(2,:),'xm','MarkerSize',5);    %# Plot line 1
h1 = plot(p2(1,:),p2(2,:),'or','MarkerSize',5);    %# Plot line 1

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
