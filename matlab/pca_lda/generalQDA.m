%This script follows the formula given in http://lyle.smu.edu/~mhd/8331sp02/abu.ppt
%to compute the QDA of the data whose dimensionality is already reduced by using PCA

%Perform the PCA on the MMG data to reduce the dimensionality of the data
generalPCA

%Decompose reducedFeatureMatrix into the individual group matrices
groupMatrix_1 = reducedFeatureMatrix(1:sum(group==1),:);
groupMatrix_2 = reducedFeatureMatrix(sum(group==1)+1:sum(group==1)+sum(group==2),:);

%Find mean of the group matrices and the complete data matrix
groupMatrix_1_Mean = mean(groupMatrix_1);
groupMatrix_2_Mean = mean(groupMatrix_2);

globalMean = mean(reducedFeatureMatrix);

%Generate the mean corrected data matrix by subtracting global mean from groupMatrices
meanCorrected_groupMat_1 = groupMatrix_1 - repmat(globalMean,size(groupMatrix_1,1),1);
meanCorrected_groupMat_2 = groupMatrix_2 - repmat(globalMean,size(groupMatrix_2,1),1);

%Count the number of elements in each group [since group is a ]
n1 = sum(group==1);      %Count elements in group 1
n2 = sum(group==2);      %Count elements in group 2
n = n1+n2;

%Compute the covariance matrix from mean corrected data
covMatGr_1 = transpose(meanCorrected_groupMat_1)*meanCorrected_groupMat_1/n1;
covMatGr_2 = transpose(meanCorrected_groupMat_2)*meanCorrected_groupMat_2/n2;

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
discrimFunc_at_1 =  log(prior(1))-(transpose(testDataReducedFeatures - transpose(groupMatrix_1_Mean))/covMatGr_1)*(testDataReducedFeatures - transpose(groupMatrix_1_Mean)) - 0.5*log(det(covMatGr_1));
discrimFunc_at_2 =  log(prior(2))-(transpose(testDataReducedFeatures - transpose(groupMatrix_2_Mean))/covMatGr_2)*(testDataReducedFeatures - transpose(groupMatrix_2_Mean)) - 0.5*log(det(covMatGr_2));

if (discrimFunc_at_1 == discrimFunc_at_2)
    disp(0)
elseif (discrimFunc_at_1 > discrimFunc_at_2)
    disp(1)
else
    disp(2)
end