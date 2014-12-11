function [good_frames] = process_input(varargin)
% PROCESS_INPUT
%      [good_frames] = PROCESS_INPUT returns the number of good frames
%      identified by PROCESS_INPUT, which takes as input live data from the
%      default recording device as long as 'IsProcessingData' is set to 1.
%
%      [good_frames] = PROCESS_INPUT('filepath') returns the number of good
%      frames found when processing the input file identified by filepath.
%
%      In either case, each good frame is sent to the feature extraction /
%      pattern recognition pipeline, and is handled asynchronously from
%      there.
%
% See also: SETAPPDATA, MAIN_GUI
    
    % Good frame counter
    good_frames = 0;
    
    % If we have an argument, a filepath was passed
    NumberOfArguments = nargin;
    if NumberOfArguments > 0
        FilePath = varargin{1};
    end
    
    % 8kHz is the lowest sample rate supported on development machine
    SampleRate = 8000;
    SamplesPerFrame = 80;
    
    % If a filename was given, setup a dsp.AudioFileReader
    if exist('FilePath', 'var')
        Input = dsp.AudioFileReader(FilePath, 'PlayCount', 1,...
                'OutputDataType','double','SamplesPerFrame', SamplesPerFrame);
        is_live = false;
    % Otherwise, use a dsp.AudioRecorder for live input
    else
        Input = dsp.AudioRecorder('SampleRate', SampleRate,...
                'OutputDataType','double','SamplesPerFrame', SamplesPerFrame);
        is_live = true;
    end
    
    % Number of training samples required
    nTrSamples = 20;
    
    fprintf('Training Phase begins...\n Please provide %d training samples with %d for each class.\n',nTrSamples,nTrSamples/4);
    
    % Setup buffers for use in `extract_window`
    raw = zeros(70,2);
    power = zeros(70,2);
    
    % Setup counter to identify how long ago valid window was detected
    sinceStart=0;
    
    % Setup a superFrame which captures 600ms of 2 channels of audio data 
    % when valid window detected
    superFrame=zeros(60,2);
    
    % Setup the trData and job_fifo that contains the complete mmg window data
    trData=cell([20,1]);
    job_fifo=cell([1,2]);
    
    % Setup the variable to store window status of valid window
    windowStatus=nan;
    
    % Setup the loop counter
    loopCounter=0;
    
%     IsProcessingAudio = 1;
%     while IsProcessingAudio==1
%     While IsProcessingAudio == 1
    % This is set in `main_gui`
    while getappdata(0, 'IsProcessingAudio')
        % Increment the loopcounter
        loopCounter = loopCounter+1;
        
        % Take a frame from the input (either from a file or from live input)
        frame = step(Input);
        
        % Downsample the frame
        frame = downsample(frame,80);
        
        % Iterate over each sample in the frame, passing it to `extract_window`
        if ~strcmp(windowStatus,'start') 
            for i=1:size(frame,1)
                t1=tic;
                [windowStatus, raw, power] = extract_window(frame(i,:), raw, power);
%                 fprintf('Time taken for xtract win is %d \n',toc(t1));
            end
        else
            sinceStart=sinceStart+1;
            if sinceStart<=45
                superFrame(sinceStart+15,:)=frame;
            end
        end
        
        % If end of frame reached, increment the good frame counter and append in job fifo
        if  sinceStart>=65 
            % Increment frame counter
            good_frames = good_frames + 1;

            % Setup complete Current frame data
            superFrame(1:15,:) = raw(end-14:end,:);
            
            % Distribute data between train and test sets
            if good_frames<=nTrSamples
                % Append train data in trData
                trData(good_frames,:)={superFrame};
                fprintf('Training Sample Number - %d\n',good_frames);
            else
                % Append test data in job fifo
                job_fifo=[{superFrame 0};job_fifo(1:end,:)];
            end
                            
            % When 20 tr samples collected, train the PR pipeline
            if good_frames==nTrSamples
                % Define the training sample labels
                trGrp = [1;2;3;4;
                         1;2;3;4;
                         1;2;3;4;
                         1;2;3;4;
                         1;2;3;4;];
                
                 % Train the classifier
                [~,classifier_Handles]=patternReco(trData,trData,trGrp,'dataVec');
                
                fprintf('Training End\n');
            end
            
            % Reset since start
            sinceStart=0;
            
            % Reset the window variables
            windowStatus=nan;
            raw = zeros(70,2);
            power = zeros(70,2);
        end
        
        %% Read the JOB_FIFO and perform prediction
        % Get the sample window from the job_fifo for which status is 0
        if cell2mat(job_fifo(end,2))==0
            t2=tic;
            currentTestSample(1,:,:) = job_fifo{end,1};
            
            % Predict for the current job
            prediction = classifier_Handles{2}(currentTestSample);
            fprintf('Current Recognised Gesture Class is - %d\n',prediction)

            % Update the status of the current job
            job_fifo(end,2)={1};          % Job done
            % fprintf('Time taken for prediction of one job is %d \n',toc(t2));
        end
            
        if size(job_fifo,1)>1
            t3=tic;
            % Update the job_buf by deleting from the end
            job_fifo = job_fifo(1:end-1,:);
%             fprintf('Time taken for job_fifo clearing is %d \n',toc(t3));
        end
        
        % `drawnow` is required for IsProcessingAudio to be changed inside `main_gui`
        drawnow;
        
        % If we are reading from a file, and we have read all data in the
        % file, exit the while loop
        if ~is_live
            if Input.isDone
                break;
            end
        end
    end

    % Dispose of the dsp.AudioFilePlayer / dsp.AudioRecorder
    release(Input);
end