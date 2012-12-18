clear; close all;

tic()

img0 = double( rgb2gray(imread('./image_sequence/0000.png')) );
[height, width, d] = size(img0);
numImages = 45;

[points3D, framesT0, descriptorsT0] = initTracking(img0);

% imshow(img1, [0 255]);
% for i=1:size(framesT0, 2);
%     
%     hold on;
%     plot(framesT0(1, i), framesT0(2, i), 'xr');
%     hold off;
%     
% end


images = zeros(height, width, numImages-1);
% correspondences = zeros(height, width, 2*(numImages-1));
% homographies = zeros(3, 3, numImages-1);

for i=1:numImages-1
  	i
    if(i < 10)
        filename = sprintf('./image_sequence/000%d.png', i);
    else
        filename = sprintf('./image_sequence/00%d.png', i);
    end
    
    currImg = single(rgb2gray(imread(filename)));
    images(:, :, i) = currImg;

    [m1,m2,cons,H,] = computeCorrespondences(images(:, :, i), framesT0, descriptorsT0,[]);
    
    
    % ///////////////// plot matches ////////////////////
    offsetX = size(img0,2);
    offsetY = size(img0,1);

    canvas = zeros( max(offsetY,size(currImg,1)), offsetX+size(currImg,2));
    canvas(1:offsetY,1:offsetX) = img0;
    canvas(1:size(currImg,1),offsetX+1:offsetX+size(currImg,2)) = currImg;




    figHandle = figure();
    imshow(canvas,[0 255]);

     hold on;
     for matchId=1:size(m1,2)
%        plot(m1(1,i),m1(2,i),'xr'); 
%        
%        plot(m2(1,i)+offsetX,m2(2,i),'oy');
        title( sprintf('res%04d.png: Matches: %d - Inliers: %d',i,size(m1,2),size(cons,2)) );
       if(any(cons==matchId))
        plot([m1(1,matchId),m2(1,matchId)+offsetX],[m1(2,matchId),m2(2,matchId)],'-xb');
       else
        plot([m1(1,matchId),m2(1,matchId)+offsetX],[m1(2,matchId),m2(2,matchId)],'-xr');
       end
     end
     hold off;
     
     saveas(figHandle,sprintf('results/res%04d.png',i),'png'); %name is a string

    
end

toc()

input('press any key to finish');
close all;
