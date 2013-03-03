function [featureMatrix]=genFeatureMatrix(A,numberSamples,numberFeatures)
featureMatrix=zeros(numberSamples,numberFeatures);
for i=1:numberSamples
    featureMatrix(i,:)=generateFeatures(A(i,:));
end
