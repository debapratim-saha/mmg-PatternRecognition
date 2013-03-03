%Total Features considered as of now = 7
numberOfFeatures=7;

% Load raw data
%[data,group]=someRandomData();
[trainData,group,testData] = loadMmgData();

% Generate feature matrix from the data above
trainFeatureMatrix = genFeatureMatrix(trainData,size(trainData,1),numberOfFeatures);
testFeatureMatrix = genFeatureMatrix(testData,size(testData,1),numberOfFeatures);

%Generate the mean adjusted featureMatrix
meanAdjFeatureMatrix=trainFeatureMatrix - repmat(mean(trainFeatureMatrix),size(trainFeatureMatrix,1),1);

% Generate Reduced Feature Matrix
[reducedFeatureMatrix,principalEigVec] = principalComp(trainFeatureMatrix);         %this generates a matrix with features in rows and samples in col
reducedFeatureMatrix = transpose(reducedFeatureMatrix);                               %this creates a matrix similar to featureMatrix                                     

%Generate the scatter plot of "reducedFeatureMatrix" classified by the "group"
gscatter(reducedFeatureMatrix(:,1),reducedFeatureMatrix(:,2),group)
grid on
