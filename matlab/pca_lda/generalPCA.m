% Load raw data and its corresponding groups for training and test data
loadMmgData;

% Generate feature matrix from the data above
trainFeatureMatrix = genFeatureMatrix(trainingData,size(trainingData,1),numberOfFeatures,numberChannels,Fs,sampleSize);
testFeatureMatrix = genFeatureMatrix(testData(:,1:sampleSize,:),size(testData,1),numberOfFeatures,numberChannels,Fs,sampleSize);

%Generate the mean adjusted featureMatrix
meanAdjFeatureMatrix=trainFeatureMatrix - repmat(mean(trainFeatureMatrix),size(trainFeatureMatrix,1),1);

%Compute the Fisher Score for all the features
assignFisherScore;

%Sort the Fisher Score Matrix 
[sortedFisherScore,sortedFisherIndex]= sort(fisherScoreMatrix,2,'descend');

%Select the top discriminatory features
fisherReducedTrainMatrix = zeros(size(trainFeatureMatrix,1),nFisherReducedFeat);
fisherReducedTestMatrix = zeros(size(testFeatureMatrix,1),nFisherReducedFeat);
for i=1:nFisherReducedFeat
    fisherReducedTrainMatrix(:,i)=trainFeatureMatrix(:,sortedFisherIndex(i));
    fisherReducedTestMatrix(:,i)=testFeatureMatrix(:,sortedFisherIndex(i));
end

% Perform the PCA and Generate Reduced Feature Matrix
%[reducedFeatureMatrix,principalEigVec] = principalComp(trainFeatureMatrix);                                        %this generates a matrix with features in rows and samples in col
[reducedFeatureMatrix,principalEigVec,eigValues] = principalComp(fisherReducedTrainMatrix,nPcaReducedFeat);         %this generates a matrix with features in rows and samples in col
%[reducedFeatureMatrix,principalEigVec] = principalComp(meanAdjFeatureMatrix);                                      %this generates a matrix with features in rows and samples in col

% %Generate the scatter plot of "reducedFeatureMatrix" classified by the "group"
% gscatter(reducedFeatureMatrix(:,1),reducedFeatureMatrix(:,2),group)
% grid on
