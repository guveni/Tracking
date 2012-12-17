img1 = rgb2gray(imread('./image_sequence/0000.png'));


[points3D, framesT0, descriptorsT0] = initTracking(img1);

imshow(img1, [0 255]);
for i=1:size(framesT0, 2);
    
    hold on;
    plot(framesT0(1, i), framesT0(2, i), 'xr');
    hold off;
    
end
