function [knnResult]=knnMultiClass(loocv,testIndices,loocvTestCount,totalSamples,groupCount,samplePath,resultPath,nFisherReducedFeat,nPcaReducedFeat,knn,numberOfFeatures)
%Perform PCA on the sample data
generalPCA;

%Fit the knn model to training data
knnModel = ClassificationKNN.fit(transpose(reducedFeatureMatrix),group,'NumNeighbors',knn);

%Predict the class of test data points
testReducedMatrix=transpose(principalEigVec)*transpose(fisherReducedTestMatrix);
knnResult=predict(knnModel,transpose(testReducedMatrix));