img1 = rgb2gray(imread('./image_sequence/0000.png'));
[height, width, d] = size(img1);
numImages = 45;

[points3D, framesT0, descriptorsT0] = initTracking(img1);

% imshow(img1, [0 255]);
% for i=1:size(framesT0, 2);
%     
%     hold on;
%     plot(framesT0(1, i), framesT0(2, i), 'xr');
%     hold off;
%     
% end


images = zeros(height, width, numImages-1);
correspondences = zeros(height, width, 2*(numImages-1));
homographies = zeros(3, 3, numImages-1);

for i=1:numImages-1
  	i
    if(i < 9)
        filename = sprintf('./image_sequence/000%d.png', i+1);
    else
        filename = sprintf('./image_sequence/00%d.png', i+1);
    end
    
    images(:, :, i) = rgb2gray(imread(filename));

    [correspondences(:, :, i:i+1) , homographies(:, :, i)] = computeCorrespondences(images(:, :, i), framesT0, descriptorsT0);
    
end

