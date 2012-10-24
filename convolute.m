function newImg = convolute(img,mask,treatment )
%CONVOLUTE convolutes an image with a mask
%   image: an array containing the image (gray-values)
%   mask: the mask that is used for the convolution
%   treatment: 1 -> border
%              2 -> mirror
    [R,C] = size(img); % rows/columns
    
    [M,N] = size(mask); % rows/columns of mask
    
    newImg = zeros(R,C); % 
    
    m = floor(M/2);
    n = floor(N/2);
    
    mask = normalizeMask(mask);
    
    % outer loops iterate over all pixels of image
    for r=1:1:R
        for c=1:1:C
            

            % inner loops iterate over elements of mask
            sum = 0;
            for i=-m:1:m
                for j=-n:1:n
                    
                    % get intensity at position (-i and -j because the mask
                    % must be rotated 180°
                    imgVal = getImgIntensityAtPos(r-i,c-j,img,treatment);
                    maskVal = mask(i+m+1,j+n+1);

                    sum = sum + double(imgVal)*maskVal;
                    
                end
            end
            newImg(r,c) = sum;
        end
    end 
end



function intensity = getImgIntensityAtPos(r,c,img,treatment)
    [R,C] = size(img);
    
    if treatment == 1
    
%         if r < 1  % upper edge
%             r = 1;
%         elseif r > R  % lower corner
%             r = R;
%         end
%         
%         if c < 1  % left corner
%             c = 1;
%         elseif c > C  % right corner
%             c = C; 
%         end

        % shorter:
        r = max(min(r,R),1);
        c = max(min(c,C),1);
        
        
    elseif treatment == 2
    
        if r < 1  % upper edge
            r = abs(r)+1;
        elseif r > R  % lower corner
            r = r+1-((r-R)*2);
        end
        if c < 1  % left corner
            c = abs(c)+1;
        elseif c > C  % right corner
            c = c+1-((c-C)*2); 
        end
    end
    
    intensity = img(r,c);
    
end



function normMask = normalizeMask(mask)
 ss =    sum(mask(:));
                  % just a hack to avoid normalizing matrizes with very 
                  % small sum (especially for matrizes which should have 
                  % sum 0 but haven't because of rounding-errors)
                  % we must find a better solution; maybe call  the function
                  % separately before calling convolute
 if abs(ss) < 0.1 
    normMask = mask ;
 else
    normMask = mask/ss ;
end
end
