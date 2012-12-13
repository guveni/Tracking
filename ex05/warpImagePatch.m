function [warpedPatches, transformations] = warpImagePatch(patch, numWarps)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[height, width] = size(patch);

% warp patch around harrisPoints and see if harrisPoint is robust enough
% R? R?? diag(?1,?2) R?
%the rotation angles are randomly chosen from [0;2pi]
%?1,?2 are randomly chosen from [0.6; 1.5]
theta = (2*pi) * rand(numWarps, 1);
phi = (2*pi) * rand(numWarps, 1);
lambdas = 0.6 + 0.9 * rand(numWarps, 2);

%build the rotation/scale matrices
rotationTheta = zeros(2, 2, numWarps);
rotationPhi = zeros(2, 2, numWarps);
invRotationPhi = zeros(2, 2, numWarps);
scaling = zeros(2, 2, numWarps);

for i=1:numWarps
   
    rotationTheta(:,:,i) = [cos(theta(i)) sin(theta(i));
                            -sin(theta(i)) cos(theta(i))];
                
    rotationPhi(:,:,i) = [cos(phi(i)) sin(phi(i));
                        -sin(phi(i)) cos(phi(i))];
                
    invRotationPhi(:,:,i) = [cos(phi(i)) -sin(phi(i)); 
                            sin(phi(i)) cos(phi(i))];
                
    scaling(:,:,i) = [lambdas(i, 1) 0;
                    0 lambdas(i, 2)];

end

warpedPatches = ones(height, width, numWarps) * -1;
transformations = zeros(3, 3, numWarps);


for b = 1:numWarps
    
    transformation = rotationTheta(:, :, b) * invRotationPhi(:, :, b) * scaling(:, :, b) * rotationPhi(:, :, b);
    transformation = [transformation, [0;0]];
    transformation = [transformation; [0 0 1]];
    tform = maketform('affine', transformation);

    center = [ceil(height/2); ceil(width/2); 1];
    transCenter = transformation*center;
    xOff = transCenter(1) - center(1);
    yOff = transCenter(2) - center(2);
    
    transImage = imtransform(patch, tform, 'XData', [1 width], 'YData', [1 height], 'FillValues', -1);
    transImage = imtransform(patch, tform, 'FillValues', -1);
    %transImage = imtransform(patch, tform, 'XData', [xOff-ceil(width/2) xOff+ceil(width/2)], 'YData', [yOff-ceil(height/2) yOff+ceil(height/2)], 'FillValues', -1);
    %transImage = imtransform(patch, tform, 'XData', [xOff width+xOff], 'YData', [yOff height+yOff], 'FillValues', -1);
    %[temptransImage, xdata, ydata] = imtransform(patch, tform, 'FillValues', -1);
    %xdata
    %ydata
    %cent = [ceil((ydata(2)-ydata(1))/2); ceil((xdata(2)-xdata(1))/2)]
    %cent = [ceil((ydata(2)+ydata(1))/2); ceil((xdata(2)+xdata(1))/2)]
    %transImage = temptransImage(cent(1)-ceil(height/2):cent(1)+ceil(height/2), cent(2)-ceil(width/2):cent(2)+ceil(width/2));
    %transImage = imtransform(patch, tform, 'Size', [height, width], 'FillValues', -1);
    imshow(transImage, [0 255]);
    %warpedPatches(:, :, b) = transImage;


    %produce noise for undefined image points (i.e. no point was warped
    %to this position
    for r = 1 : height
        for c = 1 : width
            if(warpedPatches(r, c, b) == -1)
               if(randi(2) == 1)
                   warpedPatches(r, c, b) = 0;
               else
                   warpedPatches(r, c, b) = 255;
               end
            end
        end
    end
end

end

