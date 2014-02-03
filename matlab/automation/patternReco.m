function [prediction,classifier_Handles]=patternReco(timeSeriesData,trWindowLimits,trGrp,testSample)
        
    % Return the handles to the classifiers
    classifier_Handles={@trainClassifier; @testClassifier};

    %% If no argument, assume a default sample to check the classifier
    if nargin<4
        testSample='sample_21';
        prediction=nan;
        
        if nargin<3
            % Define the training samples and their groups
            path = [pwd filesep 'using_script' filesep];

            trMat   ={'sample_1';'sample_5';'sample_9';'sample_13';'sample_17';
                      'sample_2';'sample_6';'sample_10';'sample_14';'sample_18';
                      'sample_3';'sample_7';'sample_11';'sample_15';'sample_19';
                      'sample_4';'sample_8';'sample_12';'sample_16';'sample_20'};

            % Read the train samples
            trN = length(trMat);
            trSample = zeros(trN, 60, 2);    
            for i = 1:trN
                rawSigTr = wavread([path trMat{i} '.wav']);
                trSample(i,:,:)=downsample(rawSigTr,80);        
            end

            trGrp   =[1;1;1;1;1;
                      2;2;2;2;2;
                      3;3;3;3;3;
                      4;4;4;4;4;];
        
        else
            % Extract the training window samples
            trN = size(trWindowLimits,1);
            trSample = zeros(trN,60,2);
            for i=1:trN
                trSample(i,:,:) = timeSeriesData(trWindowLimits(i,1):trWindowLimits(i,2),:);
            end
        end
        
    end
    
    %% Pattern Reco pipeline        
    
    % Train the model
    [model,pEigVec]=trainClassifier(trSample,trGrp);
    
%     % Read the test samples
%     rawSigTst=wavread(strcat(path,testSample));
%     teSample(1,:,:)=downsample(rawSigTst,80);
% 
%     tic;
%     prediction = testClassifier(teSample);
%     toc

    
    function [model,pEigVec]=trainClassifier(trSample,trGrp)
        Fs=100;
        nFisherReducedFeat=32;
        nPcaReducedFeat=4;
        knn=3;

        %Feature extraction
        trX=genFeatureMatrix(trSample,Fs);

        %Compute the Fisher Score for all the features
        % redFeatTrMat=assignFisherScore(trX,trGrp,nFisherReducedFeat);

        % Perform the PCA and Generate Reduced Feature Matrix
        [pcaFeatMat,pEigVec] = principalComp(trX,nPcaReducedFeat);         %this generates a matrix with features in rows and samples in col

        %Fit the knn model to training data
        model = ClassificationKNN.fit(transpose(pcaFeatMat),trGrp,'NumNeighbors',knn);
    end

    function [prediction]=testClassifier(testSample)
        % Extract Features
        teX = genFeatureMatrix(testSample,100);

        % Feature Reduction
        redFeatTeMat = pEigVec' * teX';

        % Make prediction
        prediction=predict(model,redFeatTeMat');
    end
end
    
    

