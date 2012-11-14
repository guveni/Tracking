function [ finalResult ] = harrisLaplace( resolutionLevels, img, s0, k ,alpha, tHigh, tLow )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [R, C] = size(img);
    nonMaxSupprRadius = 1;
    
    % find all harris-points
    allHarris = zeros(R,C,resolutionLevels);
    
    oriImg = img;
    
    for n=1:resolutionLevels
         
        img = oriImg;
        response = computeResponse(img, s0, k, n, alpha);
    
        thresholded = (response > tHigh);
   
        localMaxima = findLocalMaxima(response, nonMaxSupprRadius);
    
        harrisPoints = localMaxima.*thresholded;
        
        allHarris(:,:,n) = harrisPoints;
    end
    
    
    allLaplace = zeros(R, C, resolutionLevels);
    
    for i = 1:resolutionLevels
        
        img = oriImg;
        
        sigmaD = s0 * k^i;
        
        filter = fspecial('gaussian',floor(3*sigmaD),sigmaD);
        img = imfilter(img,filter,'conv');

        Ix = derivateX(img);
        Iy = derivateY(img);
        
        Ixx = derivateX(Ix);
        Iyy = derivateY(Iy);
        
        allLaplace(:,:,i) = (sigmaD^2)*(Ixx+Iyy);
        
        % s_L = s0 * k^i;   
        % laplaceMask(:,:,i) = s_L * s_L * imfilter(img,fspecial('log', floor(6 * s_L + 1), s_L),'replicate');
    end
    
    finalResult = zeros(R,C);
    
    for s = 1:resolutionLevels
        for r = 1:R
            for c = 1:C
                % if harris-point
                if (allHarris(r,c,s) == 1)
                    isCandidate = true;
                    if(s > 1) 
                        if( allLaplace(r,c,s-1) > allLaplace(r,c,s) )
                            isCandidate = false;
                        end                       
                    end
                    
                    if(s < resolutionLevels)
                        if( allLaplace(r,c,s+1) > allLaplace(r,c,s) )
                            isCandidate = false;
                        end
                    end
                    
                    if(isCandidate == true)
                        finalResult(r,c) = s;
                    end
                end
            end
        end
    end
    
end

