function [reducedMatrix,principalEigVec]=principalComp(featureMatrix)
covarMatrix=cov(featureMatrix);
[eVec,eVal]=eigs(covarMatrix,10);

principalEigVec = eVec(:,1:2);
reducedMatrix = transpose(principalEigVec)*transpose(featureMatrix);

% principalEigVec = eVec();
% reducedMatrix = transpose(principalEigVec)*transpose(featureMatrix);
