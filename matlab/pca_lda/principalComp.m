function [reducedMatrix,principalEigVec]=principalComp(featureMatrix)
covarMatrix=cov(featureMatrix);
[eVec,eVal]=eigs(covarMatrix,10);

principalEigVec = eVec(:,1:4);
reducedMatrix = transpose(principalEigVec)*transpose(featureMatrix);

