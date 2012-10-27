function kernel = getGaussian2d( sigma )
%GETGAUSSIAN2D returns a 2D gaussian kernel
%   sigma: 

    center = ceil(sigma*3/2);
    kernel = zeros(sigma*3);
    
    for i=1:3*sigma
        for j=1:3*sigma
            u = i - center;
            v = j - center;
            % kernel(i,j) = 1 / ( 2*pi*sigma^2) * exp ( -0.5 * (u^2+v^2) / (sigma^2));
            % don't normalize here -> done in convolute by dividing by the sum
            % of elements
            kernel(i,j) = exp ( -0.5 * (u^2+v^2) / (sigma^2));
        end
    end

end

