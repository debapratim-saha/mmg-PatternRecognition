clear all;
progDisp = 1;

%Sample Description 
totalSamples=44; 

%Number of groups in data
groupCount=4;

%Total Features considered in this data analysis
numberOfFeatures=16;

%Define the number of Fisher Reduced Features
nFisherReducedFeat = 4;

%Define the number of PCA Reduced Features
nPcaReducedFeat = 4;

%Initialise the sample root addresse
rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\Microphone DATA\Users Study\USER\UserD\Sample2\';

%Address to the folder where each sample is stored
samplePath=strcat(rootPath,'using_script\');

%Address to the folder containing results
resultPath=strcat(rootPath,'results\');

%LOOCV variable
loocv = 1;

%Setup the progress bar for each k 
% if progDisp
%     h2 = waitbar(0,'Performing PR for various k = 1 to 10');
% end

% for k=1:10
%     %Define the number of nearest neighbors
%     if k~=8
%         knn = k;
%     end

knn=3;
    %Setup the progress bar for each k 
    if progDisp
        h1 = waitbar(0,'Learning and Testing for each sample ...');
    end

    loocvResultKnn=zeros(totalSamples+5,2);            %the 6 more rows are for storing the final groupwise counts of correct classification
    for i=1:totalSamples
        [knnresult]=knnMultiClass(loocv,[i],i,totalSamples,groupCount,samplePath,resultPath,nFisherReducedFeat,nPcaReducedFeat,knn,numberOfFeatures);
        loocvResultKnn(i,:)=[i,knnresult];

        %update Progress bar for one loocv run
        if progDisp
           waitbar(i/totalSamples,h1);
        end
    end
    
    %Close the progress bar object h1 and update h2
    if progDisp
        close(h1)
        %waitbar(k/10,h2);
    end

    groupCountCorrect=zeros(totalSamples/groupCount,1);
    for i=1:totalSamples
        if loocvResultKnn(i,2)==mod(i,groupCount)
            groupCountCorrect(mod(i,groupCount)+1) = groupCountCorrect(mod(i,groupCount)+1) +1;
            loocvResultKnn(totalSamples+2+mod(i,groupCount),:)=[mod(i,groupCount),groupCountCorrect(mod(i,groupCount)+1)];
        end
    end

    resultWriteVar='KNN';
    writeResult;
% end
% 
% close(h2)