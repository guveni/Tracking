function [ correspondences, H ] = computeCorrespondences( img, framesT0, descriptorsT0)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[frames,descriptors] = vl_sift(single(img));

% figure();
% imshow(img, [0 255]);
% 
% for i=1:size(frames, 2);
%     
%     hold on;
%     plot(frames(1, i), frames(2, i), 'or');
%     hold off;
%     
% end


matches = vl_ubcmatch(descriptorsT0, descriptorsT0);

p1 = framesT0(1:2, matches(1, :));
p1(3,:) = ones(1,size(p1,2));

p2 = frames(1:2,matches(2,:));
p2(3,:) = ones(1,size(p2,2));

[H,cons,tmp,Hbest] = doAdaptiveRansac(p1,p2,4,0.5,0.99);

correspondences = [p1 p2];

end