function [ noisyImg ] = addSaltPepperNoise( img, percentageOfNoise )
%ADDSALTPEPPERNOISE Exercise 02_01 b) Adds salt and pepper noise to an image
%   img the image to add noise
%   percentageOfNoise percentage of pixels that should be noisy

    [M,N] = size(img);
    
    noisyImg = zeros(M,N);
    
    
    for r = 1:1:M
       for c = 1:1:N
           number = randi([0,99]);
           
           if percentageOfNoise > number
               saltOrPepper = randi(2);
               
               if(saltOrPepper == 1) % 1 = pepper, 2 = salt
                    noisyImg(r,c) = 0;
               else
                    noisyImg(r,c) = 255;
               end
           else
               noisyImg(r,c) = img(r,c);
           end
       end
    end

    noisyImg = uint8(noisyImg);
end

