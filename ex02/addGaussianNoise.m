function [ noisyImg ] = addGaussianNoise( img, sigma )
%ADDGAUSSIANNOISE Exercise 02_01 b) adds gaussian noise to an image
%   img: image to add noise
%   sigma: std-deviation
    
    s = size(img);

    randMatrix = normrnd(0,sigma,s);    % create a matrix with normal-distributet random-variables
    
    noisyImg = double(img)+randMatrix;
    noisyImg = max(zeros(s),noisyImg);  % set values smaller than 0 to 0
    noisyImg = min(ones(s)*255,noisyImg);   % set values larger than 255 to 255
    noisyImg = uint8(noisyImg);     % round values to int8

end

