function newImg = applyBilateralFilter(img,sigmaD,sigmaR)
%ApplyBilateralFilter applies bilateral filter to an image
%   image: an array containing the image (gray-values)
%   sigmaD: sigma for closeness (spacial smoothing)
%   sigmaR: sigma for similarity (combining of pixel values)

    [R,C] = size(img); % rows/columns
    
    newImg = zeros(R,C); % 
    
    m = floor(sigmaD*1.5);
    n = m;
        
    h = waitbar(0,'Progress ...');
    set(h,'Name',sprintf('running bilateral filter with sigmaD %d and sigmaR %d',sigmaD,sigmaR));

    
    % outer loops iterate over all pixels of image
    for r=1:1:R
        for c=1:1:C
            

            % inner loops iterate over elements of mask
            sum = 0;
            cSum = 0; % for normalisation
            
            for y=-m:1:m
                for x=-n:1:n
                    
                    % get intensity at position (-i and -j because the mask
                    % must be rotated 180°
                    
                    % if(x~=0 && y~=0) 
                        
                        pixelPosY = max(min(r+y,R),1);
                        pixelPosX = max(min(c+x,C),1);

						% intensity of pixel in image where the filter is applied
                        iXi = img(pixelPosY,pixelPosX);

                        % compute similarity (gray-value-difference between
                        % current pixel and center-pixel)
                        delta = abs(img(r,c)-iXi);
                        similarity = exp(-0.5*((delta/sigmaR)^2));

                        % compute closeness (distance between current pixel
                        % and center-pixel)
                        dist = norm([pixelPosY pixelPosX] - [r c]);
                        closeness = exp(-0.5*((dist/sigmaD)^2));

                        sum = sum + iXi*closeness*similarity;
                        cSum = cSum + closeness*similarity;
                    % end
                end
            end
            % normalize
            newImg(r,c) = sum / cSum;
        end
        waitbar(r/R);
    end 
    
    close(h);
end





