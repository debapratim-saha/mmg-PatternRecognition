%Total Features considered in this data analysis
numberOfFeatures=19;

% Load raw data
loadMmgData;

% Generate feature matrix from the data above
trainFeatureMatrix = genFeatureMatrix(trainingData,size(trainingData,1),numberOfFeatures,numberChannels);
testFeatureMatrix = genFeatureMatrix(testData(:,1:30870,:),size(testData,1),numberOfFeatures,numberChannels);

%Generate the mean adjusted featureMatrix
meanAdjFeatureMatrix=trainFeatureMatrix - repmat(mean(trainFeatureMatrix),size(trainFeatureMatrix,1),1);

% Generate Reduced Feature Matrix
[reducedFeatureMatrix,principalEigVec] = principalComp(trainFeatureMatrix);         %this generates a matrix with features in rows and samples in col

%[reducedFeatureMatrix,principalEigVec] = principalComp(meanAdjFeatureMatrix);         %this generates a matrix with features in rows and samples in col

% %Generate the scatter plot of "reducedFeatureMatrix" classified by the "group"
% gscatter(reducedFeatureMatrix(:,1),reducedFeatureMatrix(:,2),group)
% grid on
