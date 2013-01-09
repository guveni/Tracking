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
        luR = r;
        luC = c;
        rlR = r + height;
        rlC = c + width/2;
        
        resp1 = intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        luR = r;
        luC = c + width/2;
        rlR = r + height;
        rlC = c + width;
        
        resp2 = intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        featureResponse = resp1 - resp2;
        
    case 2
        luR = r;
        luC = c;
        rlR = r + height/2;
        rlC = c + width;
        
        resp1 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        luR = r + height/2;
        luC = c;
        rlR = r + height;
        rlC = c + width;
        
        resp2 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        featureResponse = resp1 - resp2;
        
    case 3
        
        luR = r;
        luC = c;
        rlR = r + height;
        rlC = c + width/3;
        
        resp1 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        luR = r;
        luC = c + width/3;
        rlR = r + height;
        rlC = c + width/3*2;
        
        resp2 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        luR = r;
        luC = c + width/3*2;
        rlR = r + height;
        rlC = c + width;
        
        resp3 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        featureResponse = resp1 - resp2 + resp3;
        
    case 4
        
        luR = r;
        luC = c;
        rlR = r + height/3;
        rlC = c + width;
        
        resp1 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        luR = r + height/3;
        luC = c;
        rlR = r + height/3*2;
        rlC = c + width;
        
        resp2 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        luR = r + height/3*2;
        luC = c;
        rlR = r + height;
        rlC = c + width;
        
        resp3 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        featureResponse = resp1 - resp2 + resp3;
        
    case 5
        
        luR = r;
        luC = c;
        rlR = r + height/2;
        rlC = c + width/2;
        
        resp1 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        luR = r;
        luC = c + width/2;
        rlR = r + height/2;
        rlC = c + width;
        
        resp2 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
        
        luR = r + height/2;
        luC = c;
        rlR = r + height;
        rlC = c + width/2;
        
        resp3 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B
               
        luR = r + height/2;
        luC = c + width/2;
        rlR = r + height;
        rlC = c + width;
        
        resp4 =  intImg(rlR, rlC) ...%C
            + intImg(luR, luC) ...%A
            - intImg(rlR, luC) ...%D
            - intImg(luR, rlC);%B 
        featureResponse = resp1 - resp2 - resp3 + resp4;
               
end

end

