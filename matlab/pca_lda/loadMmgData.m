%function [trainingData,group,testData]=loadMmgData()
%This function loads all the MMG data formatted as follows -
%row    = new sample and
%column = sample data

%Number of channels of data
numberChannels=2;
sampleSize=4800;

%Number of groups in data
groupCount=4;

%Sample Description 
totalSamples=36; 

% %Initialise the sample root addresse
% rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\Microphone DATA\At Forearm\';
% 
% %Address to the folder containing the time series
% tseriesFolder='Thumb27\';

%Initialise the sample root addresse
rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\Microphone DATA\At Forearm\USER\UserC\';

%Address to the folder containing the time series
tseriesFolder='Sample3\';

%Address to the folder where each sample is stored
sampleFolder='using_script\';

%Address to the folder containing results
resultFolder='results\';

%Read one sample to store the frequency and nbits for the project
%Reading one sample is enough cos all other samples possess the same property
[y,Fs,nbits]=wavread(strcat(rootPath,tseriesFolder,sampleFolder,'sample_1.wav'));

%Read the samples into a matrix with format -
%row=sample->channel,       || This has to be done because matlab always
%column=sample->data,       || inputs values in the [row,column] tuple for a 3D matrix
%depth=sample->number
eventSample=zeros(numberChannels,sampleSize,totalSamples);                     %Each row contains 600ms sample of each movement
for i=1:totalSamples
    eventSample(:,:,i) = transpose(wavread(strcat(rootPath,tseriesFolder,sampleFolder,strcat('sample_',num2str(i),'.wav'))));
end

%Convert the eventSample matrix in the following format-
%row=sample->number,        || This has to be done to make sure the date 
%column=sample->data,       || lies in a format that is easily understood
%depth=sample->channel
eventSample=permute(eventSample,[3 2 1]);

%Define trainData %%This below one is ONLY FOR SAMPLE#25
% trainDataIndices=[1;2;3;4;5;6;
%                   7;8;9;10;11;12;
%                   13;14;15;16;17;18;
%                   19;20;21;22;23;24];

%Define trainData
trainDataIndices=[9;13;17;21;29;33;
                  10;14;18;22;30;34;
                  11;15;19;23;31;35;
                  12;16;20;24;32;36];
              
group=[1;1;1;1;1;1;
       2;2;2;2;2;2;
       3;3;3;3;3;3;
       0;0;0;0;0;0];
   
trainingData=zeros(size(trainDataIndices,1),sampleSize,numberChannels);
%group=zeros(size(trainDataIndices,1),1);         
for i=1:size(trainDataIndices,1)
    trainingData(i,:,:) = eventSample(trainDataIndices(i),:,:);
    %group(i,1) = mod(trainDataIndices(i),groupCount);                          %assign class to the samples based on their index
end

%Define testData
% testData=eventSample(37,:);
testData=zeros(totalSamples-size(trainDataIndices,1),sampleSize+1,numberChannels);
i=1; eventIndex=1; 
while eventIndex <= totalSamples
    if ~any(eventIndex == trainDataIndices)
        testData(i,1:sampleSize,:) = eventSample(eventIndex,:,:);
        testData(i,sampleSize+1,:) = [eventIndex,eventIndex];
        i=i+1;
    end
    eventIndex=eventIndex+1;
end

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