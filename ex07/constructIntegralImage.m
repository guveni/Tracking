function [ intImg ] = constructIntegralImage( img )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[rows, cols] = size(img);

intImg = zeros(rows, cols);
intImg = double(intImg);

intImg(1, 1) = img(1, 1);

for x = 1:cols
    for y = 1:rows
        
        if x == 1 && y == 1
            continue;
            
        elseif x == 1 
            intImg(y, x) = intImg(y-1, x) + img(y, x);
            
        elseif y == 1
            intImg(y, x) = intImg(y, x-1) + img(y, x);
            
        else
            
            val = intImg(y-1, x-1);
            
            for xx = 1:x
                
                val = val + img(y, xx);
                
            end
               
            for yy = 1:y
                
                val = val + img(yy, x);
                
            end
            
            intImg(y, x) = val;
        
        end
     end
end

end