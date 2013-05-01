%function [trainingData,group,testData]=loadMmgData()
%This function loads all the MMG data formatted as follows -
%row    = new sample and
%column = sample data

%Number of groups in data
groupCount=4;

%Sample Description 
totalSamples=28; 

%Initialise the sample root addresse
rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\Microphone DATA\At Forearm\';

%Address to the sample under test
sampleFolder='Thumb23\using_script\';
eventSample=zeros(totalSamples,30870);                     %Each row contains 400ms sample of each movement
for i=1:totalSamples
    eventSample(i,:) = transpose(wavread(strcat(rootPath,sampleFolder,strcat('sample_',num2str(i),'.wav'))));
end

%Define trainData
trainDataIndices=[1;5;9;13;17;
                  2;6;10;14;18;
                  3;7;11;15;19;
                  4;8;12;16;20];
trainingData=zeros(size(trainDataIndices,1),30870);
group=zeros(size(trainDataIndices,1),1);         
for i=1:size(trainDataIndices,1)
    trainingData(i,:) = eventSample(trainDataIndices(i),:);
    group(i,1) = mod(trainDataIndices(i),groupCount);                          %assign class to the samples based on their index
end

% %Define testData
% testData=zeros(totalSamples-size(trainDataIndices,1),30870+1);
% i=1; eventIndex=1; 
% while eventIndex <= totalSamples
%     if ~any(eventIndex == trainDataIndices)
%         testData(i,:) = [eventSample(eventIndex,:),eventIndex];
%         i=i+1;
%     end
%     eventIndex=eventIndex+1;
% end
testData=eventSample(26,:);