%Fit the knn model to training data
knnModel = ClassificationKNN.fit(transpose(reducedFeatureMatrix),group,'NumNeighbors',5);

%Predict the class of test data points
testReducedMatrix=transpose(principalEigVec)*transpose(fisherReducedTestMatrix);
knnResult=predict(knnModel,transpose(testReducedMatrix));