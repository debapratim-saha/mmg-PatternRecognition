function prediction=main(testSample)

    path=strcat(pwd,'\using_script\');

    trMat   ={'sample_1';'sample_5';'sample_9';'sample_13';'sample_17';
              'sample_2';'sample_6';'sample_10';'sample_14';'sample_18';
              'sample_3';'sample_7';'sample_11';'sample_15';'sample_19';
              'sample_4';'sample_8';'sample_12';'sample_16';'sample_20'};

    trGrp   =[1;1;1;1;1;
              2;2;2;2;2;
              3;3;3;3;3;
              4;4;4;4;4;];
	
    %Read the train samples
    trN=length(trMat);
    trSample=zeros(trN,60,2);
    for i=1:trN
        rawSigTr=wavread(strcat(path,trMat{i},'.wav'));
        trSample(i,:,:)=downsample(rawSigTr,80);        
    end
    
    % Train the model
    [model,pEigVec]=trainClassifier(trSample,trGrp);
    
    % Read the test samples
    rawSigTst=wavread(strcat(path,testSample));
    teSample(1,:,:)=downsample(rawSigTst,80);
    
    tic;
    % Extract Features
    teX = genFeatureMatrix(teSample,100);
    
    % Feature Reduction
    redFeatTeMat = pEigVec' * teX';
    
    % Make prediction
    prediction=predict(model,redFeatTeMat');
    toc
    

