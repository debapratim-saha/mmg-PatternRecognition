function windowBuffer()
    %% INITIALIZATION
    mmgSample='user2_dual_4motion_2.wav';
    scriptFolder='using_script\';

    numChannels=2;
    path = [pwd filesep mmgSample];    %Path for the complete sample file
    scriptFolderPath=[pwd filesep scriptFolder];   %Path for the folder where individual event files will be kept
    if exist(scriptFolderPath,'dir')
    else
        mkdir(scriptFolderPath);
    end

    %Read the wave file and downsample it
    [origMMGdata,fs,nbits] = wavread(path);
    lowSampleFreq=1000; sPeriod=1/lowSampleFreq;                 % Downsample frequency in Hz
    timeSeriesData=downsample(origMMGdata,fs/lowSampleFreq);

    % Continue from here
    sampleLength = length(timeSeriesData);
    t=linspace(0,(1/lowSampleFreq)*sampleLength,sampleLength);
    
    %% TRAINING PHASE
    % Define the training sample labels
    trGrp = [1;2;3;4;
             1;2;3;4;
             1;2;3;4;
             1;2;3;4;
             1;2;3;4;];

    % Define buffers and windowLimits
    raw_buf = zeros(70,2);
    pow_buf = zeros(70,2);
    trWindowLimits = zeros(1,2);
    sampleCount = 0; 
    deadZone = 20;                  % deadZone is for ensuring intersample distance
    i=1;    
    
    % Define the number of training windows and 
    nTrSample=20; 
    
    % starting point of test samples
    testStInd = 2160;
    
    % Get the training sample windows
    while i < testStInd
        [win_status,raw_buf,pow_buf]=extract_window(timeSeriesData(i,:),raw_buf,pow_buf);

        % Check if valid window, if YES, update windowLimits 
        if strcmp(win_status,'start')==1
            sampleCount=sampleCount+1;
    %         windowLimits(sampleCount,:)=[i-winStartOffset,i-winStartOffset+60];
            trWindowLimits(sampleCount,:)=[i-14,i+45];

            % Jump to the end of current sample and reset all buffers
    %         i=i-winStartOffset+61;
            i=i+45+deadZone;
            raw_buf = zeros(70,2);
            pow_buf = zeros(70,2);
        else
            i=i+1;
        end
    end    
    
    % Get the Classifier handles from main and Train the classifier
    if size(trWindowLimits,1)==nTrSample
        [~,classifier_Handles]=patternReco(timeSeriesData,trWindowLimits,trGrp);
    end
    
    %% TESTING and PREDICTION Phase
    
    % Start the testing phase with new initializations
    % Define buffers and windowLimits
    raw_buf = zeros(70,2);
    pow_buf = zeros(70,2);
    job_fifo = zeros(1,3);
    tstWindowLimits = zeros(1,2);
    sampleCount = 0; 
    
    % Start the index after training phase
    i=testStInd; 

    while i < (sampleLength-50)
        [win_status,raw_buf,pow_buf]=extract_window(timeSeriesData(i,:),raw_buf,pow_buf);

        % Plot the window ending at i
%         plotWindow(i); break;

        % Check if valid window, if YES, update job_fifo
        if strcmp(win_status,'start')==1
            sampleCount=sampleCount+1;
    %         windowLimits(sampleCount,:)=[i-winStartOffset,i-winStartOffset+60];
            tstWindowLimits(sampleCount,:)=[i-14,i+45];

            % Append job and status at the top of the job_fifo
            job_fifo=cat(1,[tstWindowLimits(sampleCount,:) 0],job_fifo);

            % Jump to the end of current sample and reset all buffers
    %         i=i-winStartOffset+61;
            i=i+45+deadZone;
            raw_buf = zeros(70,2);
            pow_buf = zeros(70,2);
        else
            i=i+1;
        end

        % Get the sample window from job_buf for which status is 0(or undone)
        if job_fifo(end,3)==0                   
            if job_fifo(end,1)~=0 && job_fifo(end,2)~=0     % because job_fifo is initialised to [0,0]
                currentTestSample(1,:,:) = timeSeriesData(job_fifo(end,1):job_fifo(end,2),:);

                % Predict for the current job
                prediction = classifier_Handles{2}(currentTestSample);
%                 job_fifo(end,1:2)
                disp(prediction)
                
                % Update the status of the current job
                job_fifo(end,3)=1;          % Job done
            end
        end
            
        if size(job_fifo,1)>1
            % Update the job_buf by deleting from the end
            job_fifo = job_fifo(1:end-1,:);
        end
    end
end

function plotWindow(i)
% Plot the window --> For debug purposes
    if i==146
        subplot(3,1,1)
        plot(raw_buf);grid on;
        subplot(3,1,2)
        plot(pow_buf);grid on;
        subplot(3,1,3)
        plot([[0 0];diff(pow_buf)]/sPeriod);grid on;
    end
end
