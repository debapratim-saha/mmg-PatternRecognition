%Total Features considered in this data analysis
numberOfFeatures=19;
Nfeat_ULDA=2;

% Load raw data
loadMmgData;

% Generate feature matrix from the data above
trainFeatureMatrix = genFeatureMatrix(trainingData,size(trainingData,1),numberOfFeatures,numberChannels);
testFeatureMatrix = genFeatureMatrix(testData(:,1:sampleSize,:),size(testData,1),numberOfFeatures,numberChannels);

%Generate the mean adjusted featureMatrix
meanAdjFeatureMatrix=trainFeatureMatrix - repmat(mean(trainFeatureMatrix),size(trainFeatureMatrix,1),1);

% Generate reduced feature matrices
%[feature_training,feature_testing] = ulda_feature_reduction(feature_training,Nfeat,class_training,feature_testing);
[reducedFeatureMatrix,principalEigVec] = principalComp(trainFeatureMatrix);         %this generates a matrix with features in rows and samples in col

G = uldaFeatureReduce(trainFeatureMatrix, group);
reducedFeatureMatrix = (trainFeatureMatrix*G);
Nfeat_ulda = size(reducedFeatureMatrix,2);
Nfeat_out = min(Nfeat_out,Nfeat_ulda);
reducedFeatureMatrix = reducedFeatureMatrix(:,1:Nfeat_out);
