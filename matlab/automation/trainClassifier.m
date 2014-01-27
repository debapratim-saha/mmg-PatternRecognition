function [model,pEigVec]=trainClassifier(trSample,trGrp)

Fs=100;
nFisherReducedFeat=32;
nPcaReducedFeat=4;
knn=3;

%Feature extraction
trX=genFeatureMatrix(trSample,Fs);

%Compute the Fisher Score for all the features
% redFeatTrMat=assignFisherScore(trX,trGrp,nFisherReducedFeat);

% Perform the PCA and Generate Reduced Feature Matrix
[pcaFeatMat,pEigVec] = principalComp(trX,nPcaReducedFeat);         %this generates a matrix with features in rows and samples in col

%Fit the knn model to training data
model = ClassificationKNN.fit(transpose(pcaFeatMat),trGrp,'NumNeighbors',knn);