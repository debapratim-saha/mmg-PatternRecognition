%function [trainingData,group,testData]=loadMmgData()
%This function loads all the MMG data formatted as follows -
%row    = new sample and
%column = sample data

%Number of channels of data
numberChannels=2;

%Number of groups in data
groupCount=4;

%Sample Description 
totalSamples=47; 

%Initialise the sample root addresse
rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\Microphone DATA\At Forearm\';

%Address to the folder containing sample under test
sampleFolder='Thumb25\';

%Read the samples into a matrix with format -
%row=sample->channel,       || This has to be done because matlab always
%column=sample->data,       || inputs values in the [row,column] tuple for a 3D matrix
%depth=sample->number
eventSample=zeros(numberChannels,30870,totalSamples);                     %Each row contains 700ms sample of each movement
for i=1:totalSamples
    eventSample(:,:,i) = transpose(wavread(strcat(rootPath,sampleFolder,strcat('sample_',num2str(i),'.wav'))));
end

%Convert the eventSample matrix in the following format-
%row=sample->number,        || This has to be done to make sure the date 
%column=sample->data,       || lies in a format that is easily understood
%depth=sample->channel
eventSample=permute(eventSample,[3 2 1]);

%Define trainData
trainDataIndices=[1;2;3;4;5;6;
                  7;8;9;10;11;12;
                  13;14;15;16;17;18;
                  19;20;21;22;23;24];
group=[1;1;1;1;1;1;
       2;2;2;2;2;2;
       3;3;3;3;3;3;
       0;0;0;0;0;0];
   
trainingData=zeros(size(trainDataIndices,1),30870,numberChannels);
%group=zeros(size(trainDataIndices,1),1);         
for i=1:size(trainDataIndices,1)
    trainingData(i,:,:) = eventSample(trainDataIndices(i),:,:);
    %group(i,1) = mod(trainDataIndices(i),groupCount);                          %assign class to the samples based on their index
end

%Define testData
% testData=eventSample(37,:);
testData=zeros(totalSamples-size(trainDataIndices,1),30870+1,numberChannels);
i=1; eventIndex=1; 
while eventIndex <= totalSamples
    if ~any(eventIndex == trainDataIndices)
        testData(i,1:30870,:) = eventSample(eventIndex,:,:);
        testData(i,30871,:) = [eventIndex,eventIndex];
        i=i+1;
    end
    eventIndex=eventIndex+1;
end