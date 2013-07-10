function [reducedMatrix,principalEigVec,eigValues]=principalComp(featureMatrix)
covarMatrix=(size(featureMatrix,1)-1)*cov(featureMatrix);                     %we have to find the scatter matrix, and matlab uses unbiased estimate -> so scatter=(n-1)*covariance;
[eVec,eVal]=eigs(covarMatrix,12);

principalEigVec = eVec(:,1:4);
eigValues = eVal;
reducedMatrix = transpose(principalEigVec)*transpose(featureMatrix);

