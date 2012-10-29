function newImg = applyBilateralFilter(img,sigmaD,sigmaR)
%ApplyBilateralFilter applies bilateral filter to an image
%   image: an array containing the image (gray-values)
%   sigmaD: sigma for closeness (spacial smoothing)
%   sigmaR: sigma for similarity (combining of pixel values)

    [R,C] = size(img); % rows/columns
    
    newImg = zeros(R,C); % 
    
    m = floor(sigmaD*1.5);
    n = m;
        
    % outer loops iterate over all pixels of image
    for r=1:1:R
        for c=1:1:C
            

            % inner loops iterate over elements of mask
            sum = 0;
            cSum = 0;
            
            for y=-m:1:m
                for x=-n:1:n
                    
                    % get intensity at position (-i and -j because the mask
                    % must be rotated 180°
                    
                    if(x~=0 || y~=0) 
                        
                    
                    
                        pixelPosY = max(min(r+y,R),1);
                        pixelPosX = max(min(c+x,C),1);

                        iXi = img(pixelPosY,pixelPosX);

                        delta = abs(img(r,c)-iXi);
                        similarity = exp(double(-0.5*((delta/sigmaR)^2)));

                        dist = norm([pixelPosY pixelPosX] - [r c]);
                        closeness = exp(-0.5*((dist/sigmaD)^2));

                        sum = sum + iXi*closeness*similarity;
                        cSum = cSum + closeness*similarity;
                    end
                end
            end
            newImg(r,c) = sum / cSum;
        end
    end 
end





