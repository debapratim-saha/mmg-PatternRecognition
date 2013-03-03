function [reducedMatrix,principalEigVec]=principalComp(featureMatrix)
covarMatrix=cov(featureMatrix);
[eVec,eVal]=eigs(covarMatrix);

reducedMatrix = transpose(eVec(:,1:2))*transpose(featureMatrix);
principalEigVec = eVec(:,1:2);
