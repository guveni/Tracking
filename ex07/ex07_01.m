clear;
close all;

% d = load('data1.mat');
% dat1 = d.dat;
 d = load('data2.mat');
 dat1 = d.dat;
% d = load('data3.mat');
% dat1 = d.dat;

% Parameters (the number of iterations that are done)
% Ts = [1 2 3 4 5 10 25 50 100 200 500];
Ts = [1000];

plotAll = 1; 
% plotAll = 0; 
% 0: plot only accuracy for different T's
% 1: also plot results for single classifiers

% for storing accuracy of each round
accuracys = zeros(1,size(Ts,2));


% plot original data
if plotAll == 1
    figure();
    hold on;
    for i=1:size(dat1,1)
       if( dat1(i,3) == 1)
           plot(dat1(i,1),dat1(i,2),'bx')
       else
           plot(dat1(i,1),dat1(i,2),'rx')
       end
    end
    hold off;
end

for round=1:size(Ts,2)
    
    

    T = Ts(1,round); % number of iterations/weak classifiers
    numSamples = size(dat1,1);



    h = zeros(T,3);
    % weak classifiers
    % one row for each iteration
    % three columns per classifier: 
    %   first indicates if horizontal (1) or vertical (2)
    %   second is for the position on the axis
    %   third is 1 if positive samples are above/right of the line, 2 otherwise
    % e.g. (1 20) means a horizontal line crossing the Y-axis at y=20

    alphas = zeros(1,T);
    % betas = zeros(1,T);

    w = zeros(T+1,numSamples); 
    % weights
    % one line for each itereation
    % one column for each sample-point

    w(1,:) = ones(1,numSamples)/numSamples;

    for t=1:T

        % find best classifier

        [h1 h2 h3 error correctOnes] = findBestClassifier(dat1,w(t,:));

        h(t,:) = [h1 h2 h3];
        beta = error/(1-error);
        alphas(1,t) = -log(beta);

        % compute new weights
        w(t+1,:) = w(t,:) .* ( (beta.*ones(1,numSamples)) .^ (correctOnes==1) );


        % normalize weights (so that sum = 1)
        w(t+1,:) = w(t+1,:) ./ sum(w(t+1,:));

    end

    % plot classifier result
    if plotAll == 1

        minX = min(dat1(:,1));
        maxX = max(dat1(:,1));
        minY = min(dat1(:,2));
        maxY = max(dat1(:,2));

        [X,Y] = meshgrid(minX:1:maxX,minY:1:maxY); 
        out = getHypothesis(h,alphas,X,Y);

        % plot 3D (exact response value)
        figure();
        mesh(X,Y,out)
        hold off;

        % plot 2D (only positive or negative)
        figure()
        hold on;
        for r=1:5:maxY-minY
           for c=1:5:maxX-minX
               if out(r,c) > 0
                   plot(X(r,c),Y(r,c),'g+');
               else
                   plot(X(r,c),Y(r,c),'rx');
               end
           end
        end
        hold off;
    end
    


    tp=0;
    fp=0;
    tn=0;
    fn=0;

    if plotAll==1
        figure();
        hold on;
    end
    
    for i=1:size(dat1,1)

        if i==200
            a=5;
        end
        x = dat1(i,1);
        y = dat1(i,2);
        truth = dat1(i,3);
       hypot = getHypothesis(h,alphas,x,y);
       if( hypot > 0)
           if truth > 0
               if plotAll == 1
                   plot(x,y,'g+')
               end
               tp=tp+1;
           else
               if plotAll ==1
                   plot(x,y,'m+')
               end
               fp=fp+1;
           end

       else
           if truth < 0
               if plotAll ==1
                   plot(x,y,'bx')
               end
               tn=tn+1;
           else
               if plotAll ==1
                   plot(x,y,'rx')
               end
               fn=fn+1;
           end

       end
    end
    if plotAll ==1
        hold off;
    end
    
    accuracys(round) = (tp+tn)/(tp+tn+fp+fn);

end



figure();
semilogx(Ts,accuracys,'rx-');

figure();
plot(Ts,accuracys,'rx-');


