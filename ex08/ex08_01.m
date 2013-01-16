close all;
clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Predefined stuff %%%%%%%%%%%%%%%%%%%%%%%%%%

img = double(rgb2gray(imread('image_sequence/0000.png')));

rectangle = [300;180;100;100];
left = rectangle(1);
right = rectangle(1)+rectangle(3);
top = rectangle(2);
bottom = rectangle(2)+rectangle(4);

width = right-left;
height = bottom-top;

numGridPoints = 100;

stepX = width/(sqrt(numGridPoints)-1);
stepY = height/(sqrt(numGridPoints)-1);

[gridX,gridY] = meshgrid(1:stepX:width+1,1:stepY:height+1);

gridX = gridX +left-1;
gridY = gridY +top-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Start with calculations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img = normalizeMatrix(img);

oriGridInt = getGridIntensities(img,gridX,gridY,eye(3));

figure(1);
imshow(img,[-2 2]);
hold on;
plot([left right right left left],[top top bottom bottom top],'r-');
plot(gridX,gridY,'bo');

A = buildA(img,gridX,gridY,rectangle);


currP = zeros(8,1);

numImages = 45;
for i=0:numImages-1
  	i
    if(i < 10)
        filename = sprintf('./image_sequence/000%d.png', i);
    else
        filename = sprintf('./image_sequence/00%d.png', i);
    end
    currImg = double(rgb2gray(imread(filename)));
    
    for n=5:1
        for ctr=1:5
    
            H = getHFromP(currP,rectangle);

            intensities = getGridIntensities(currImg,gridX,gridY,H);

            intensities = normalizeMatrix(intensities);

            di = oriGridIntensities - intensities;

            dp = A(:,:,5)*di;
            
            currP = currP + dp;
        end
    end
end

















% oriGridInt = getGridIntensities(img,gridX,gridY,eye(3));
% 
% 
% 
% P = zeros(8,numGridPoints);
% I = zeros(numGridPoints,numGridPoints);
% 
% A = zeros(8,numGridPoints,5);
% 
% for warpId = 1:5
%     warpId
%     for n = 1:numGridPoints  % random warps
% 
%        
%         [warpImg,warpedGridInt,H,dp] = warpRectangle(img,rectangle,gridX,gridY,warpId*3);
% 
%         P(:,n) = dp;
%         
%         di = oriGridInt - warpedGridInt;
%         di = reshape(di,numGridPoints,1);
%         I(:,n) = di;
%         
% 
% % 
% %         figure(2);
% %         imshow(warpImg,[-2 2]);
% %         hold on;
% %         plot(gridX,gridY,'bo');
% 
%     end
%     A(:,:,warpId) = P*I'*(I*I');
% end
