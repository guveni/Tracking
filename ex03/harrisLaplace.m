function [ finalResult ] = harrisLaplace( resolutionLevels, img, s0, k ,alpha, tHar, tLap )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [R, C] = size(img);
    nonMaxSupprRadius = 1;
    
    % find all harris-points
    allHarris = zeros(R,C,resolutionLevels+1);
    
    
    for n=0:resolutionLevels
         
        harrisPoints=applyMultiscaleHarris(img,s0,k,n,alpha,tHar,nonMaxSupprRadius);
                
        allHarris(:,:,n+1) = harrisPoints;
        
    end
    
    % build laplacian
    
    allLaplace = zeros(R, C, resolutionLevels+1);
    
    for i = 0:resolutionLevels
        
        sigma = s0 * k^i;
        
        filter = fspecial('gaussian',floor(3*sigma),sigma);
        img = imfilter(img,filter,'conv');

        % derive once to get first derivation
        Ix = derivateX(img);
        Iy = derivateY(img);
        
        % derive again to get second derivation
        Ixx = derivateX(Ix);
        Iyy = derivateY(Iy);
        
        allLaplace(:,:,i+1) = abs((sigma^2)*(Ixx+Iyy));
                
    end
    
    finalResult = zeros(R,C);
    
    for s = 0:resolutionLevels
        for r = 1:R
            for c = 1:C
                % if harris-point
                if (allHarris(r,c,s+1) == 1)
                    isCandidate = true;
                    
                    currLap = allLaplace(r,c,s+1);
                    
                    % check if level s-1 has higher response
                    if(s > 1) 
                        if( allLaplace(r,c,s-1+1) > currLap )
                            isCandidate = false;
                        end                       
                    end
                    
                    % check if level s+1 has higher response
                    if(s < resolutionLevels)
                        if( allLaplace(r,c,s+1+1) > currLap )
                            isCandidate = false;
                        end
                    end
                    
                    % if candidate is local maxima of laplace in
                    % scale-dimension and larger than the threshold
                    if(isCandidate == true)
                        if(currLap > tLap)
                            finalResult(r,c) = s+1;
                        end
                    end

                end
            end
        end
    end
    
end

