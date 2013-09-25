%function [trainingData,group,testData]=loadMmgData()
%This function loads all the MMG data formatted as follows -
%row    = new sample and
%column = sample data

%Number of channels of data
numberChannels=2;
sampleSize=4800;

%Read one sample to store the frequency and nbits for the project
%Reading one sample is enough cos all other samples possess the same property
[y,Fs,nbits]=wavread(strcat(samplePath,'sample_1.wav'));

%Read the samples into a matrix with format -
%row=sample->channel,       || This has to be done because matlab always
%column=sample->data,       || inputs values in the [row,column] tuple for a 3D matrix
%depth=sample->number
eventSample=zeros(numberChannels,sampleSize,totalSamples);                     %Each row contains 600ms sample of each movement
for i=1:totalSamples
    eventSample(:,:,i) = transpose(wavread(strcat(samplePath,strcat('sample_',num2str(i),'.wav'))));
end

%Convert the eventSample matrix in the following format-
%row=sample->number,        || This has to be done to make sure the date 
%column=sample->data,       || lies in a format that is easily understood
%depth=sample->channel
eventSample=permute(eventSample,[3 2 1]);

[trainingData,testData,group]=splitDataset(loocv,testIndices,eventSample,sampleSize,numberChannels,totalSamples,groupCount);

%Count the number of elements in each group 
numGrSamples=zeros(groupCount+1,1);
for i=1:groupCount
    numGrSamples(i) = sum(group==mod(i,groupCount));      %Count elements in group i
end
numGrSamples(groupCount+1) = sum(numGrSamples);

%Define the extents of each of the groups in the training data set
gr1=1:numGrSamples(1);
gr2=numGrSamples(1)+1:numGrSamples(1)+numGrSamples(2);
gr3=numGrSamples(1)+numGrSamples(2)+1:numGrSamples(1)+numGrSamples(2)+numGrSamples(3);
gr4=numGrSamples(1)+numGrSamples(2)+numGrSamples(3)+1:numGrSamples(groupCount+1);

%Define the prior for the experiment. It should mostly be 0.5 because both the groups are equally probable.
%prior = [n1/n;n2/n];
prior = 1/groupCount;