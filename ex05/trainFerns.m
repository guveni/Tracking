function [harrisPoints, samplePoints, histograms] = trainFerns( I, fernSize, fernCount,numWarps,patchSize,maxHarrisPoints )
%TRAINFERNS Summary of this function goes here
%   Detailed explanation goes here

    % format:
    % p1x p2x p3x p4x
    % p1y p2y p3y p4y
    harrisPoints = findRobustHarrisPoints(I,patchSize,maxHarrisPoints);






    
    % two line represent x and y coordinate of one point of feature
    % four lines of one column represent both points of one feature
    % format:
    % f111x f121x f131x f141x
    % f111y f121y f131y f141y
    % f112x f122x f132x f142x
    % f112y f122y f132y f142y
    % f211x f221x f231x f241x
    % f211y f221y f231y f241y
    % f212x f222x f232x f242x
    % f212y f222y f232y f242y
    %
    % feature(fern,featureOfFern,pointOfFeature);
    % fern means the index of the ferns. range: 1-fernCount
    % featureOfFern means the position of a feature in fern. range for one fern: 1-fernSize
    % pointOfFeature means if point1 or point2. for the training we then check if img(point1) < img(point2)
    samplePoints = zeros(fernCount*4,fernSize);

    % one column per harris-point
    % one line represents one bin
    % fernCount times 2^fernSize features -> fernCount*2^fernSize lines
    % init with one, so that the value can't become zero
    histograms = ones(fernCount*2^fernSize,size(harrisPoints,2));

        
    transformation = zeros(3,3);
    
    for w = 1:numWarps
    
        w
        
        theta = (2*pi) * rand(1, 1);
        phi = (2*pi) * rand(1, 1);
        lambdas = 0.6 + 0.9 * rand(1, 2);

        %build the rotation/scale matrices
        rotationTheta = zeros(2, 2);
        rotationPhi = zeros(2, 2);
        invRotationPhi = zeros(2, 2);
        scaling = zeros(2, 2);

        rotationTheta(:,:) = [cos(theta) sin(theta);
                                -sin(theta) cos(theta)];

        rotationPhi(:,:) = [cos(phi) sin(phi);
                            -sin(phi) cos(phi)];

        invRotationPhi(:,:) = [cos(phi) -sin(phi); 
                                sin(phi) cos(phi)];

        scaling(:,:) = [lambdas(1, 1) 0;
                        0 lambdas(1, 2)];



    
        transformation = rotationTheta(:, :) * invRotationPhi(:, :) * scaling(:, :) * rotationPhi(:, :);
        transformation = [transformation, [0;0]];
        transformation = [transformation; [0 0 1]];
        
        if(w==1)
           transformation = [1 0 0;0 1 0;0 0 1]; 
        end
        
        iWarp = warpNew(I,transformation);
        
%         figure();
%         imshow(iWarp,[0,255]);
%         hold on;
       
        %for each harrispoint
        for hp=1:size(harrisPoints,2)

            % TODO:
            % for warp=1:numWarps
            %   warp image for training (1000-5000 times according to ex-sheet)

            harPoint = [harrisPoints(1,hp) harrisPoints(2,hp) 0]';
            
            warpedHP = calcPointAfterWarping(harPoint,size(I),size(iWarp),transformation,0);
            
%             plot(warpedHP(1), warpedHP(2), 'r*');
            
            harrisPointX = warpedHP(1);
            harrisPointY = warpedHP(2);

            % for each fern
            for i=1:fernCount
                %two arrays containing coordinates relative to the center
                %(range eg -50:50)
                % p1x p2x p3x
                % p1y p2y p3y
                
                % only calculate rand-positions for first image
                % afterwards use the old ones
                if (w == 1)
                    randPositions1 = getRandomPositions(fernSize,patchSize);
                    randPositions2 = getRandomPositions(fernSize,patchSize);
                    
                    samplePoints(i*4-3,:) = randPositions1(1,:);
                    samplePoints(i*4-2,:) = randPositions1(2,:);
                    samplePoints(i*4-1,:) = randPositions2(1,:);
                    samplePoints(i*4-0,:) = randPositions2(2,:);
                else
                    randPositions1(1,:) = samplePoints(i*4-3,:);
                    randPositions1(2,:) = samplePoints(i*4-2,:);
                    randPositions2(1,:) = samplePoints(i*4-1,:);
                    randPositions2(2,:) = samplePoints(i*4-0,:);
                end
                
                binPos = 0;
                % for each feature of fern
                for featurePos=1:fernSize
                    samplePoint1X = harrisPointX+randPositions1(1,featurePos);
                    samplePoint1Y = harrisPointY+randPositions1(2,featurePos);
                    samplePoint2X = harrisPointX+randPositions2(1,featurePos);
                    samplePoint2Y = harrisPointY+randPositions2(2,featurePos);
try
                    if( iWarp(samplePoint1Y,samplePoint1X) < iWarp(samplePoint2Y,samplePoint2X) );
                        binPos = binPos + 2^(featurePos-1);
                    end
catch
    a = 5; 
end

                end

                histograms((i-1)*2^fernSize+binPos+1,hp) = histograms((i-1)*2^fernSize+binPos+1,hp) + 1;


            end
%             hold off;
        end

    end
    
    % normalize histogram
    % +2^fernsize, because all bins are initialised with 1
    histograms(:,:) = histograms(:,:)/(numWarps+2^fernSize);


end

