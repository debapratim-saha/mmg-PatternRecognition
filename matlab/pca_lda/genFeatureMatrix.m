function [featureMatrix]=genFeatureMatrix(A,numberSamples,numberFeatures,numberChannels)
%% This function forms the feature matrix from the given data matrix A

% First form the matrix in the following format -
%row=sample->channel,       || This has to be done because matlab always
%column=sample->data,       || inputs values in the [row,column] tuple for a 3D matrix
%depth=sample->number
 featureMatrix=zeros(numberSamples,numberFeatures*numberChannels);
 for i=1:numberSamples
    featureMatrix(i,:)=generateFeatures(A(i,:,:));
 end
