%This script is a multiclass classifier using QDA of the data whose           
%dimensionality is already reduced by using PCA                             
%FOR MORE COMPREHENSIVE DESCRIPTION ON DISCRIMINANT ANALYSIS, VISIT THE WEBSITE -
%https://onlinecourses.science.psu.edu/stat857/node/17

progDisp = 1;

%Setup the progress bar 
if progDisp
    h = waitbar(0,'Computing RMS features...');
end

%Perform the PCA on the MMG data to reduce the dimensionality of the data
generalPCA

%Count the number of elements in each group 
n=zeros(groupCount+1,1);
for i=1:groupCount
    n(i) = sum(group==mod(i,groupCount));      %Count elements in group i
end
n(groupCount+1) = sum(n);
    
%Decompose reducedFeatureMatrix into the individual group matrices
groupMatrix_1 = reducedFeatureMatrix(:,1:n(1));
groupMatrix_2 = reducedFeatureMatrix(:,n(1)+1:n(1)+n(2));
groupMatrix_3 = reducedFeatureMatrix(:,n(1)+n(2)+1:n(1)+n(2)+n(3));
groupMatrix_4 = reducedFeatureMatrix(:,n(1)+n(2)+n(3)+1:n(groupCount+1));

%Find mean of the group matrices and the complete data matrix
groupMatrix_1_Mean = mean(groupMatrix_1,2);                                 %Take the mean of each row which contains one complete vector within this group
groupMatrix_2_Mean = mean(groupMatrix_2,2);                                 %Take the mean of each row which contains one complete vector within this group
groupMatrix_3_Mean = mean(groupMatrix_3,2);                                 %Take the mean of each row which contains one complete vector within this group
groupMatrix_4_Mean = mean(groupMatrix_4,2);                                 %Take the mean of each row which contains one complete vector within this group

%globalMean = mean(reducedFeatureMatrix);

%Generate the mean corrected data matrix by subtracting global mean from groupMatrices
meanCorrected_groupMat_1 = groupMatrix_1 - repmat(groupMatrix_1_Mean,1,size(groupMatrix_1,2));
meanCorrected_groupMat_2 = groupMatrix_2 - repmat(groupMatrix_2_Mean,1,size(groupMatrix_2,2));
meanCorrected_groupMat_3 = groupMatrix_3 - repmat(groupMatrix_3_Mean,1,size(groupMatrix_3,2));
meanCorrected_groupMat_4 = groupMatrix_4 - repmat(groupMatrix_4_Mean,1,size(groupMatrix_4,2));

%Compute the covariance matrix from mean corrected data
covMatGr_1 = meanCorrected_groupMat_1*transpose(meanCorrected_groupMat_1)/(n(1)-1);
covMatGr_2 = meanCorrected_groupMat_2*transpose(meanCorrected_groupMat_2)/(n(2)-1);
covMatGr_3 = meanCorrected_groupMat_3*transpose(meanCorrected_groupMat_3)/(n(3)-1);
covMatGr_4 = meanCorrected_groupMat_4*transpose(meanCorrected_groupMat_4)/(n(4)-1);

%Define the prior for the experiment. It should mostly be 0.5 because both the groups are equally probable.
%prior = [n1/n;n2/n];
prior = 1/groupCount;

%Evaluate the test points one-by-one
testCount=size(testData,1);
result=zeros(testCount,2);
for i=1:testCount
    %Get the principal components of the testData
    testDataReducedFeatures = transpose(principalEigVec)*transpose(testFeatureMatrix(i,:));

    %Predict the class for a new data by evaluating the value of discriminant function at the given point
    %The discrim function has to be evaluated at x=<new data point> (whose definition is present in loadMmgData.m)
    discrimFunc(1) =  log(prior)-0.5*(transpose(testDataReducedFeatures - groupMatrix_1_Mean)/covMatGr_1)...
                        *(testDataReducedFeatures - groupMatrix_1_Mean) - 0.5*log(det(covMatGr_1));
    discrimFunc(2) =  log(prior)-0.5*(transpose(testDataReducedFeatures - groupMatrix_2_Mean)/covMatGr_2)...
                        *(testDataReducedFeatures - groupMatrix_2_Mean) - 0.5*log(det(covMatGr_2));
    discrimFunc(3) =  log(prior)-0.5*(transpose(testDataReducedFeatures - groupMatrix_3_Mean)/covMatGr_3)...
                        *(testDataReducedFeatures - groupMatrix_3_Mean) - 0.5*log(det(covMatGr_3));
    discrimFunc(4) =  log(prior)-0.5*(transpose(testDataReducedFeatures - groupMatrix_4_Mean)/covMatGr_4)...
                        *(testDataReducedFeatures - groupMatrix_4_Mean) - 0.5*log(det(covMatGr_4));

    %Display the index of the max of Discriminant value which represents the
    %group which evaluates to highest value
    [maxValue,maxIndex]=max(discrimFunc);
    result(i,:)=[testData(i,sampleSize+1),maxIndex];
%     disp(maxIndex)

    %update Progress bar
    if progDisp
       waitbar(i/testCount,h);
    end
end

if progDisp
    close(h)
end
