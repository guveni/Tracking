function [ featureResponse ] = haarlikeFeatures( classifier, intImg )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%classifier looks like this: [[r, c, width, height, classifier #]

featureResponse = 0;
r = classifier(1);
c = classifier(2);
width = classifier(3);
height = classifier(4);
class = classifier(5);


switch class
   
    case 1
        resp1 = intImg(r + height - 1, c + width/2 - 1) ...%C
            + intImg(r, c) ...%A
            - intImg(r + height - 1, c) ...%D
            - intImg(r, c + width/2 - 1);%B
        
        resp2 = intImg(r + height - 1, c + width - 1) ...%C
            + intImg(r, c + width/2) ...%A
            - intImg(r + height - 1, c) ...%D
            - intImg(r, c + width - 1);%B
        
        featureResponse = resp1 - resp2;
        
    case 2
        resp1 = intImg(r + height/2 - 1, c + width - 1) ...%C
            + intImg(r, c) ...%A
            - intImg(r + height/2 - 1, c) ...%D
            - intImg(r, c + width - 1);%B
        
        resp2 = intImg(r + height - 1, c + width - 1) ...%C
            + intImg(r + height/2, c) ...%A
            - intImg(r + height - 1, c) ...%D
            - intImg(r + height/2, c + width -1);%B
        
        featureResponse = resp1 - resp2;
        
    case 3
        resp1 = intImg(r + height - 1, c + width/3 - 1) ...%C
            + intImg(r, c) ...%A
            - intImg(r + height - 1, c) ...%D
            - intImg(4, c + winWidht/3 - 1);%B
        
        resp2 = intImg(r + height - 1, c + 2*width/3 - 1) ...%C
            + intImg(r, c + width/3) ...%A
            - intImg(r + height - 1, c + width/3) ...%D
            - intImg(r, c + 2*width/3 - 1);%B
        
        resp3 = intImg(r + height - 1, c + 2*width/3 - 1) ...%C
            + intImg(r, c + 2*width/3) ...%A
            - intImg(r + height - 1, c + 2*width/3) ...%D
            - intImg(r, c + width - 1);%B
        
        featureResponse = resp1 - resp2 + resp3;
        
    case 4
        resp1 = intImg(r + height/3 - 1, c + width - 1) ...%C
            + intImg(r, c) ...%A
            - intImg(r + height/3 - 1, c) ...%D
            - intImg(r, c + width - 1);%B
        
        resp2 = intImg(r + 2*height/3 - 1, c + width - 1) ...%C
            + intImg(r + height/3, c) ...%A
            - intImg(r + 2*height/3 - 1, c) ...%D
            - intImg(r + height/3 - 1, c + width - 1);%B
        
        resp3 = intImg(r + height - 1, c + width - 1) ...%C
            + intImg(r + 2*height/3, c) ...%A
            - intImg(r + height - 1, c) ...%D
            - intImg(4 + 2*height/3, c + width -1);%B
        
        featureResponse = resp1 - resp2 + resp3;
        
    case 5
        resp1 = intImg(r + height/2 - 1, c + width/2 - 1) ...%C
            + intImg(r, c) ...%A
            - intImg(r + height/2 - 1, c) ...%D
            - intImg(r, c + width/2 - 1);%B
        
        resp2 = intImg(r + height/2 - 1, c + width - 1) ...%C
            + intImg(r, c + width/2) ...%A
            - intImg(r + height/2 - 1, c + width/2) ...%D
            - intImg(r, c + width - 1);%B
        
        resp3 = intImg(r + height - 1, c + width/2 - 1) ...%C
            + intImg(r + height/2, c) ...%A
            - intImg(r + height - 1, c) ...%D
            - intImg(r + height/2, c + width/2 - 1);%B
        
        resp4 = intImg(r + height - 1, c + width - 1) ...%C
            + intImg(r + height/2, c + width/2) ...%A
            - intImg(r + height - 1, c + width/2) ...%D
            - intImg(r + height/2, c + width - 1);%B
        
        featureResponse = resp1 - resp2 + resp3 - resp4;
               
end

end

