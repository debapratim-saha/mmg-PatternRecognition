function [result,loocvResult]=QDAMultiClass(loocv,testIndices,loocvTestCount,loocvResult,totalSamples,groupCount,samplePath,resultPath,nFisherReducedFeat,nPcaReducedFeat,numberOfFeatures)
%This script is a multiclass classifier using QDA of the data whose           
%dimensionality is already reduced by using PCA                             
%FOR MORE COMPREHENSIVE DESCRIPTION ON DISCRIMINANT ANALYSIS, VISIT THE WEBSITE -
%https://onlinecourses.science.psu.edu/stat857/node/17

%Perform the PCA on the MMG data to reduce the dimensionality of the data
generalPCA

%Decompose reducedFeatureMatrix into the individual group matrices
groupFeatMatrix_1 = reducedFeatureMatrix(:,gr1);                    %gr1 is the extent of group1 in training data defined in loadMmgData
groupFeatMatrix_2 = reducedFeatureMatrix(:,gr2);                    %gr2 is the extent of group2 in training data defined in loadMmgData
groupFeatMatrix_3 = reducedFeatureMatrix(:,gr3);                    %gr3 is the extent of group3 in training data defined in loadMmgData
groupFeatMatrix_4 = reducedFeatureMatrix(:,gr4);                    %gr4 is the extent of group4 in training data defined in loadMmgData

%Find mean of the group matrices and the complete data matrix
groupFeatMatrix_1_Mean = mean(groupFeatMatrix_1,2);                                 %Take the mean of each row which contains one complete vector within this group
groupFeatMatrix_2_Mean = mean(groupFeatMatrix_2,2);                                 %Take the mean of each row which contains one complete vector within this group
groupFeatMatrix_3_Mean = mean(groupFeatMatrix_3,2);                                 %Take the mean of each row which contains one complete vector within this group
groupFeatMatrix_4_Mean = mean(groupFeatMatrix_4,2);                                 %Take the mean of each row which contains one complete vector within this group

%globalMean = mean(reducedFeatureMatrix);

%Generate the mean corrected data matrix by subtracting global mean from groupMatrices
meanCorrected_groupMat_1 = groupFeatMatrix_1 - repmat(groupFeatMatrix_1_Mean,1,size(groupFeatMatrix_1,2));
meanCorrected_groupMat_2 = groupFeatMatrix_2 - repmat(groupFeatMatrix_2_Mean,1,size(groupFeatMatrix_2,2));
meanCorrected_groupMat_3 = groupFeatMatrix_3 - repmat(groupFeatMatrix_3_Mean,1,size(groupFeatMatrix_3,2));
meanCorrected_groupMat_4 = groupFeatMatrix_4 - repmat(groupFeatMatrix_4_Mean,1,size(groupFeatMatrix_4,2));

%Compute the covariance matrix from mean corrected data
covMatGr_1 = meanCorrected_groupMat_1*transpose(meanCorrected_groupMat_1)/(numGrSamples(1)-1);
covMatGr_2 = meanCorrected_groupMat_2*transpose(meanCorrected_groupMat_2)/(numGrSamples(2)-1);
covMatGr_3 = meanCorrected_groupMat_3*transpose(meanCorrected_groupMat_3)/(numGrSamples(3)-1);
covMatGr_4 = meanCorrected_groupMat_4*transpose(meanCorrected_groupMat_4)/(numGrSamples(4)-1);


%Evaluate the test points one-by-one
testCount=size(testData,1);
result=zeros(testCount,2);
for i=1:testCount
    %Get the principal components of the testData after pre-screening by assiging Fisher Score to each feature
    testDataReducedFeatures = transpose(principalEigVec)*transpose(fisherReducedTestMatrix(i,:));

    %Predict the class for a new data by evaluating the value of discriminant function at the given point
    %The discrim function has to be evaluated at x=<new data point> (whose definition is present in loadMmgData.m)
    discrimFunc(1) =  log(prior)-0.5*(transpose(testDataReducedFeatures - groupFeatMatrix_1_Mean)/covMatGr_1)*(testDataReducedFeatures - groupFeatMatrix_1_Mean) - 0.5*log(det(covMatGr_1));
    discrimFunc(2) =  log(prior)-0.5*(transpose(testDataReducedFeatures - groupFeatMatrix_2_Mean)/covMatGr_2)*(testDataReducedFeatures - groupFeatMatrix_2_Mean) - 0.5*log(det(covMatGr_2));
    discrimFunc(3) =  log(prior)-0.5*(transpose(testDataReducedFeatures - groupFeatMatrix_3_Mean)/covMatGr_3)*(testDataReducedFeatures - groupFeatMatrix_3_Mean) - 0.5*log(det(covMatGr_3));
    discrimFunc(4) =  log(prior)-0.5*(transpose(testDataReducedFeatures - groupFeatMatrix_4_Mean)/covMatGr_4)*(testDataReducedFeatures - groupFeatMatrix_4_Mean) - 0.5*log(det(covMatGr_4));

    %Display the index of the max of Discriminant value which represents the
    %group which evaluates to highest value
    [maxValue,maxIndex]=max(discrimFunc);
    result(i,:)=[testData(i,sampleSize+1),mod(maxIndex,groupCount)];
    if loocv==1
        loocvResult(loocvTestCount,:)=result(i,:);
    end
end

