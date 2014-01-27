function [fisherScoreMatrix]=assignFisherScore(featMat,group,nFisherReducedFeat)
% This function determines the discriminatory fischer score for the features of the training data
nGr=4;
nCh=2;
nFeat=size(featMat,2)/nCh;
% Decompose the feature matrix of the training data into their respective classes
groupMatrix_1 = featMat(group==1,:);                    %gr1 is the extent of group1 in training data defined in loadMmgData
groupMatrix_2 = featMat(group==2,:);                    %gr2 is the extent of group2 in training data defined in loadMmgData
groupMatrix_3 = featMat(group==3,:);                    %gr3 is the extent of group3 in training data defined in loadMmgData
groupMatrix_4 = featMat(group==4,:);                    %gr4 is the extent of group4 in training data defined in loadMmgData

% Define the mu and sigma for the groupwise featureMatrix
mu=zeros(nGr,nFeat*nCh);
sigma=zeros(nGr,nFeat*nCh);
for i=1:nGr
    mu(i,:)     = mean(eval(strcat('groupMatrix_',num2str(i))));           %Eval is used to evaluate (here use the strcat result as a variable) the expression
    sigma(i,:)  = std(eval(strcat('groupMatrix_',num2str(i))));
end

%compute the overall Fisher score for each feature
numFeat=size(featMat,2);
fisherScoreMatrix=zeros(1,numFeat);
for feat=1:numFeat
    for i=1:(groupCount-1)
       for j=(i+1):groupCount
           score=prior*prior*(mu(i,feat)-mu(j,feat))*(mu(i,feat)-mu(j,feat))/(prior*sigma(i,feat)+prior*sigma(j,feat));
       end
    end
    fisherScoreMatrix(1,feat)=score;
end

%Sort the Fisher Score Matrix 
[~,sortedFisherIndex]= sort(fisherScoreMatrix,2,'descend');

%Select the top discriminatory features
fisherReducedTrainMatrix = zeros(size(featMat,1),nFisherReducedFeat);
for i=1:nFisherReducedFeat
    fisherReducedTrainMatrix(:,i)=featMat(:,sortedFisherIndex(i));
end

