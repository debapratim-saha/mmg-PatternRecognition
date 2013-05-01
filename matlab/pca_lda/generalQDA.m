%This script is a 2-class classifier using QDA of the data whose           
%dimensionality is already reduced by using PCA                             
%FOR MORE COMPREHENSIVE DESCRIPTION ON DISCRIMINANT ANALYSIS, VISIT THE WEBSITE -
%https://onlinecourses.science.psu.edu/stat857/node/17

%Perform the PCA on the MMG data to reduce the dimensionality of the data
generalPCA

%Count the number of elements in each group 
n=zeros(groupCount+1,1);
for i=0:groupCount-1
    n(i+1) = sum(group==i);      %Count elements in group i
end
n(groupCount+1) = sum(n);
    
%Decompose reducedFeatureMatrix into the individual group matrices
groupMatrix_1 = reducedFeatureMatrix(:,1:n(1));
groupMatrix_2 = reducedFeatureMatrix(:,n(1)+1:n(1)+n(2));

%Find mean of the group matrices and the complete data matrix
groupMatrix_1_Mean = mean(groupMatrix_1,2);                                 %Take the mean of each row which contains one complete vector within this group
groupMatrix_2_Mean = mean(groupMatrix_2,2);                                 %Take the mean of each row which contains one complete vector within this group

%Generate the mean corrected data matrix by subtracting global mean from groupMatrices
meanCorrected_groupMat_1 = groupMatrix_1 - repmat(groupMatrix_1_Mean,1,size(groupMatrix_1,2));
meanCorrected_groupMat_2 = groupMatrix_2 - repmat(groupMatrix_2_Mean,1,size(groupMatrix_2,2));

%Compute the covariance matrix from mean corrected data
covMatGr_1 = meanCorrected_groupMat_1*transpose(meanCorrected_groupMat_1)/(n(1)-1);
covMatGr_2 = meanCorrected_groupMat_2*transpose(meanCorrected_groupMat_2)/(n(2)-1);

%Define the prior for the experiment. It should mostly be 0.5 because both the groups are equally probable.
%prior = [n1/n;n2/n];
prior = 1/groupCount;

%for i=1:size(testData,1)-1
    %Get the principal components of the testData
    i=1;
    testDataReducedFeatures = transpose(principalEigVec)*transpose(testFeatureMatrix(i,:));

    %Predict the class for a new data by evaluating the value of discriminant function at the given point
    %The discrim function has to be evaluated at x=<new data point> (whose definition is present in loadMmgData.m)
    discrimFunc(1) =  log(prior)-0.5*(transpose(testDataReducedFeatures - groupMatrix_1_Mean)/covMatGr_1)*(testDataReducedFeatures - groupMatrix_1_Mean) - 0.5*log(det(covMatGr_1));
    discrimFunc(2) =  log(prior)-0.5*(transpose(testDataReducedFeatures - groupMatrix_2_Mean)/covMatGr_2)*(testDataReducedFeatures - groupMatrix_2_Mean) - 0.5*log(det(covMatGr_2));

    %Display the index of the max of Discriminant value which represents the
    %group which evaluates to highest value
    [maxValue,maxIndex]=max(discrimFunc);
    %disp(testData(i,30870+1))          
    disp(maxIndex)
%end