function [trainingData,testData,group]=splitDataset(loocv,testDataIndices,eventSample,sampleSize,numberChannels,totalSamples,groupCount)
% Send the Data Indices for the movements in test dataset for spliting the
% dataset to perform cross-validation

%Define the Test Dataset
testData=zeros(size(testDataIndices,1),sampleSize+1,numberChannels);
for i=1:size(testDataIndices,1)
    testData(i,1:sampleSize,:) = eventSample(testDataIndices(i),:,:);
    testData(i,sampleSize+1,:) = [testDataIndices(i),testDataIndices(i)];
end

%Define the Training Dataset
trainingData=zeros(totalSamples-size(testDataIndices,1),sampleSize,numberChannels);
group=zeros(totalSamples-size(testDataIndices,1),1);
classSpan = ceil((totalSamples-size(testDataIndices,1))/groupCount);
spanAdj=zeros(groupCount,1);
if loocv==1
    switch mod(testDataIndices,groupCount)
        case 1
            spanAdj=[0;1;1;1];     
        case 2
            spanAdj=[0;0;1;1];     
        case 3
            spanAdj=[0;0;0;1];     
        otherwise
            spanAdj=[0;0;0;0];     
    end
end

i=ones(groupCount,1); eventIndex=1; 
while eventIndex <= totalSamples
    if ~any(eventIndex == testDataIndices)
        movementClass=mod(eventIndex,groupCount);
        switch movementClass
            case 1
                index=classSpan*0 + i(1);
                trainingData(index,:,:) = eventSample(eventIndex,:,:);
                group(index,1) = movementClass;                          %assign class to the samples based on their index
                i(1)=i(1)+1;
            case 2
                index=classSpan*1-spanAdj(2) + i(2);
                trainingData(index,:,:) = eventSample(eventIndex,:,:);
                group(index,1) = movementClass;                          %assign class to the samples based on their index
                i(2)=i(2)+1;
            case 3
                index=classSpan*2-spanAdj(3) + i(3);
                trainingData(index,:,:) = eventSample(eventIndex,:,:);
                group(index,1) = movementClass;                          %assign class to the samples based on their index
                i(3)=i(3)+1;
            case 0
                index=classSpan*3-spanAdj(4) + i(4);
                trainingData(index,:,:) = eventSample(eventIndex,:,:);
                group(index,1) = movementClass;                          %assign class to the samples based on their index
                i(4)=i(4)+1;
            otherwise
                disp ('DATA Group Invalid')
        end
    end
    eventIndex=eventIndex+1;
end
