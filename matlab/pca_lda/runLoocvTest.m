clear all;
progDisp = 1;

%Sample Description 
totalSamples=36; 

%Number of groups in data
groupCount=4;

%Total Features considered in this data analysis
numberOfFeatures=16;

%Define the number of Fisher Reduced Features
nFisherReducedFeat = 32;

%Define the number of PCA Reduced Features
nPcaReducedFeat = 4;

%Initialise the sample root addresse
rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\Microphone DATA\Users Study\USER\UserA\Sample3\';

%Address to the folder where each sample is stored
samplePath=strcat(rootPath,'using_script\');

%Address to the folder containing results
resultPath=strcat(rootPath,'results\');

%LOOCV variable
loocv = 1;

%Setup the progress bar for each k 
if progDisp
    h2 = waitbar(0,'Performing PR for various PCA reduced dimensions = 2 to 5');
end

for d=2:5
    %this is just a momentary condition, cos we have results for d=4,
    %should delete it later on when full compilation needed.
    if d ~= 4
        nPcaReducedFeat = d;
    end
    
    %Setup the progress bar 
    if progDisp
        h1 = waitbar(0,'Learning and Testing for each sample ...');
    end

    loocvResult=zeros(totalSamples+5,2);            %the 6 more rows are for storing the final groupwise counts of correct classification
    for i=1:totalSamples
        [result,loocvResult]=QDAMultiClass(loocv,[i],i,loocvResult,totalSamples,groupCount,samplePath,resultPath,nFisherReducedFeat,nPcaReducedFeat,numberOfFeatures);

        %update Progress bar
        if progDisp
           waitbar(i/totalSamples,h1);
        end
    end

    %Close the progress bar object
    if progDisp
        close(h1)
        waitbar(d/5,h2);
    end


    groupCountCorrect=zeros(totalSamples/groupCount,1);
    for i=1:totalSamples
        if loocvResult(i,2)==mod(i,groupCount)
            groupCountCorrect(mod(i,groupCount)+1) = groupCountCorrect(mod(i,groupCount)+1) +1;
            loocvResult(totalSamples+2+mod(i,groupCount),:)=[mod(i,groupCount),groupCountCorrect(mod(i,groupCount)+1)];
        end
    end
    
    resultWriteVar='QDA';
    writeResult;
end

close(h2)