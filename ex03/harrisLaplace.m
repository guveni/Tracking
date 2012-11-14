function [ finalResult ] = harrisLaplace( resolutionLevels, img, s0, k ,alpha, tHar, tLap )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [R, C] = size(img);
    nonMaxSupprRadius = 1;
    
    % find all harris-points
    allHarris = zeros(R,C,resolutionLevels);
    
    
    for n=1:resolutionLevels
         
        harrisPoints=applyMultiscaleHarris(img,s0,k,n,alpha,tHar,nonMaxSupprRadius);
        
        figure();
        imshow(harrisPoints,[0 1]);
        
        allHarris(:,:,n) = harrisPoints;
        
    end
    
    
    allLaplace = zeros(R, C, resolutionLevels);
    
    for i = 1:resolutionLevels
        
        sigmaD = s0 * k^i;
        
        filter = fspecial('gaussian',floor(3*sigmaD),sigmaD);
        img = imfilter(img,filter,'conv');

        Ix = derivateX(img);
        Iy = derivateY(img);
        
        Ixx = derivateX(Ix);
        Iyy = derivateY(Iy);
        
        allLaplace(:,:,i) = abs((sigmaD^2)*(Ixx+Iyy));
        
    end
    
    finalResult = zeros(R,C);
    
    for s = 1:resolutionLevels
        for r = 1:R
            for c = 1:C
                % if harris-point
                if (allHarris(r,c,s) == 1)
                    isCandidate = true;
                    
                    currLap = allLaplace(r,c,s);
                    
                    if(s > 1) 
                        if( allLaplace(r,c,s-1) > currLap )
                            isCandidate = false;
                        end                       
                    end
                    
                    if(s < resolutionLevels)
                        if( allLaplace(r,c,s+1) > currLap )
                            isCandidate = false;
                        end
                    end
                    
                    if(isCandidate == true)
                        finalResult(r,c) = (currLap > tLap);
                    end

                end
            end
        end
    end
    
end

