function [ matches1,matches2,cons, H ,Mout] = computeCorrespondences( img, framesT0, descriptorsT0,M)
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


matches = vl_ubcmatch(descriptorsT0, descriptors);

matches1 = framesT0(1:2, matches(1, :));
matches1(3,:) = ones(1,size(matches1,2));

matches2 = frames(1:2,matches(2,:));
matches2(3,:) = ones(1,size(matches2,2));

[H,cons,tmp,Hbest] = doAdaptiveRansac(matches1,matches2,4,3,0.995);

matches1 = matches1(:,cons(1,:));
matches2 = matches2(:,cons(1,:));

Mout = 0;
if size(M,1) > 0
    Mout = M(:, cons(1, :));
end

end