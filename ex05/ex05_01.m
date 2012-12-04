
fernsFileName = 'fern.model';


% pseudo-code:
%
% if file.exists(fernModel)
%     [harrisPoints, samplePoints, histograms] = loadFerns(fernsFileName)
% else
%     [harrisPoints, samplePoints, histograms] = trainFerns(img1);
%     saveFerns(harrisPoints,samplePoints,histograms);
% end;
%
% matches = findMatchesWithFerns(harrisPoints,samplePoints,histograms,img2)
%
% % do the same as in last exercise (RANSAC, warping)
