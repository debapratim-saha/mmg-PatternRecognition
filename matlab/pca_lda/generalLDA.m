%This script follows the method shown in http://people.revoledu.com/kardi/tutorial/LDA/Numerical%20Example.html 
%to compute the LDA of the data whose dimensionality is already reduced by using PCA

%Perform the PCA on the MMG data to reduce the dimensionality of the data
generalPCA

%Count the number of elements in each group [since group is a ]
n1 = sum(group==1);      %Count elements in group 1
n2 = sum(group==2);      %Count elements in group 2
n = n1+n2;

%Decompose reducedFeatureMatrix into the individual group matrices
groupMatrix_1 = reducedFeatureMatrix(1:n1,:);
groupMatrix_2 = reducedFeatureMatrix((n1+1):n,:);

%Find mean of the group matrices and the complete data matrix
groupMatrix_1_Mean = mean(groupMatrix_1);
groupMatrix_2_Mean = mean(groupMatrix_2);

globalMean = mean(reducedFeatureMatrix);

%Generate the mean corrected data matrix by subtracting global mean from groupMatrices
meanCorrected_groupMat_1 = groupMatrix_1 - repmat(globalMean,size(groupMatrix_1,1),1);
meanCorrected_groupMat_2 = groupMatrix_2 - repmat(globalMean,size(groupMatrix_2,1),1);
% meanCorrected_groupMat_1 = groupMatrix_1 - repmat(groupMatrix_1_Mean,size(groupMatrix_1,1),1);
% meanCorrected_groupMat_2 = groupMatrix_2 - repmat(groupMatrix_2_Mean,size(groupMatrix_2,1),1);


%Compute the covariance matrix from mean corrected data
covMatGr_1 = transpose(meanCorrected_groupMat_1)*meanCorrected_groupMat_1/n1;
covMatGr_2 = transpose(meanCorrected_groupMat_2)*meanCorrected_groupMat_2/n2;

%covMatGr_1 = cov(meanCorrected_groupMat_1);
%covMatGr_2 = cov(meanCorrected_groupMat_2);

%Compute the inverse of pooled covariance matrix by the formula given in the website mentioned above
pooledCovMat = (n1/n)*covMatGr_1 + (n2/n)*covMatGr_2;
%invPooledCovMat = inv(pooledCovMat);

%Define the prior for the experiment. It should mostly be 0.5 because both the groups are equally probable.
%prior = [n1/n;n2/n];
prior = [0.5;0.5];

%Get the principal components of the testData
testDataReducedFeatures = transpose(principalEigVec)*transpose(testFeatureMatrix);

%Predict the class for a new data by evaluating the value of discriminant function at the given point
%The discrim function has to be evaluated at x=<new data point> (whose definition is present in loadMmgData.m)
discrimFunc_at_1 = (groupMatrix_1_Mean/pooledCovMat)*testDataReducedFeatures - 0.5*(groupMatrix_1_Mean/pooledCovMat)*transpose(groupMatrix_1_Mean) + log(prior(1));
discrimFunc_at_2 = (groupMatrix_2_Mean/pooledCovMat)*testDataReducedFeatures - 0.5*(groupMatrix_2_Mean/pooledCovMat)*transpose(groupMatrix_2_Mean) + log(prior(2));

if (discrimFunc_at_1 == discrimFunc_at_2)
    disp(0)
elseif (discrimFunc_at_1 > discrimFunc_at_2)
    disp(1)
else
    disp(2)
end