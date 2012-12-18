function [ points3D , frames, descriptors] = initTracking( img )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[frames,descriptors] = vl_sift(single(img));

A = [472.3 0.64 329.0; 0 471.0 268.3; 0 0 1];
numPoints = size(frames, 2);
points3D = zeros(3, numPoints);

for i = 1:numPoints
    
    p2D = [frames(1:2, i); 1];
    p3D = inv(A) * p2D;
    points3D(:, i) = [p3D(1)/p3D(3); p3D(2)/p3D(3); 1];
    
end



end

