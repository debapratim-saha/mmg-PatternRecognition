function [reducedMatrix,principalEigVec,eigValues]=principalComp(featureMatrix,nPcaReducedFeat)
covarMatrix=(size(featureMatrix,1)-1)*cov(featureMatrix);                     %we have to find the scatter matrix, and matlab uses unbiased estimate -> so scatter=(n-1)*covariance;
[eVec,eVal]=eigs(covarMatrix,nPcaReducedFeat);

principalEigVec = eVec(:,1:nPcaReducedFeat);
eigValues = eVal;
reducedMatrix = transpose(principalEigVec)*transpose(featureMatrix);

