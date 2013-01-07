function [ h1 h2 h3 eMin bestCorrectOnes ] = findBestClassifier( dat, weights )
%FINDBESTCLASSIFIER Summary of this function goes here
%   Detailed explanation goes here
% h1 = 1 for horizontal line, 2 for vertical line
% h2 = position of line crossing axis
% h3 = 1 if positive samples are above/right of the line, 2 otherwise
% error = error with this hypothesis
% correctOnes contain a 1 for each sample that is classified correct
% (otherwise -1)

horizontal = 1;
vertical = 2;

numData = size(dat,1);  % number of sample-points

minX = min(dat(:,1));
maxX = max(dat(:,1));
minY = min(dat(:,2));
maxY = max(dat(:,2));

eMin = 1;
for dir=1:2  % horizontal and vertical
    
   if(dir == horizontal) % horizontal line
       startPos = minY;
       endPos = maxY;
   else  % vertical line
       startPos = minX;
       endPos = maxX;
   end
   
   for pos=startPos-1:.5:endPos+1 % test all positions for line
       e = 0;
       aboveOrBelow = 1;
       
       correctOnes = ones(1,numData);
       
       for s=1:numData
           label = dat(s,3);
           
           coord = 0;
           if(dir == horizontal)
               coord = dat(s,2);
           else
               coord = dat(s,1);
           end
           
           if( (coord < pos && label==1) ||  (coord > pos && label==-1) )
               e = e + weights(1,s);
               correctOnes(1,s) = -1;
           end
           
         
       end
       
       if (e>0.5)
          e = 1-e; 
          aboveOrBelow = 2;
          correctOnes = correctOnes .* -1;
       end
       
       if (e<eMin)
          eMin = e;
          h1 = dir;
          h2 = pos;
          h3 = aboveOrBelow;
          bestCorrectOnes = correctOnes;
       end
   end
   
   
end


% figure();
% hold on;
% for i=1:numData
%    if( bestCorrectOnes(1,i) == 1)
%        plot(dat(i,1),dat(i,2),'gx')
%    else
%        plot(dat(i,1),dat(i,2),'rx')
%    end
% end
% 
% if(h1==horizontal)
%     plot([minX maxX],[h2 h2],'b-');
% else
%     plot([h2 h2],[minY maxY],'b-');
% end
% 
% hold off;

end

