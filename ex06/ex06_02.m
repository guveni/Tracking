img1 = imread('./image_sequence/0000.png');
[height, width, d] = size(img1);
numImages = 45;

[points3D, framesT0, descriptorsT0] = initTracking(img1);

images = zeros(height, width, 3, numImages-1);
correspondences = zeros(height, width, numImages-1);
homographies = zeros(3, 3, numImages-1);

for i=1:numImages-1
  	
    if(i < 9)
        filename = sprintf('./image_sequence/000%d.png', i+1);
    else
        filename = sprintf('./image_sequence/00%d.png', i+1);
    end
    
    images(:, :, :, i) = imread(filename);    

    [correspondences(:, :, i) , homographies(:, :, i)] = computeCorrespondences(images(:, :, :, i), framesT0, descriptorsT0);
    
end

