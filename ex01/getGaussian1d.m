function kernel = getGaussian1d( sigma )
%GETGAUSSIAN1D returns a 1D gaussian kernel
%   sigma: 

    center = ceil(sigma*3/2);
    kernel = zeros(sigma*3,1);

    for i=1:sigma*3
        u = i - center;
        % kernel(i) = 1 / sqrt(2*pi*sigma^2) * exp(-0.5*u^2/sigma^2);
        % don't normalize here -> done in convolute by dividing by the sum
        % of elements
        kernel(i) = exp(-0.5*u^2/sigma^2);
    end

end

