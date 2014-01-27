function [featureMatrix]=genFeatureMatrix(A,Fs)
%% This function forms the feature matrix from the given data matrix A

% The data matrix is in the following format -
%row=sample->number,        || This has to be done to make sure the date 
%column=sample->data,       || lies in a format that is easily understood
%depth=sample->channel
nSample=size(A,1);
nCh=size(A,3);
nFeat=16;

featureMatrix=zeros(nSample,nFeat*nCh);
for i=1:nSample
    featureMatrix(i,:)=parGenFeat(A(i,:,:),Fs);
end
