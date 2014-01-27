function captureMMG()
    % init the sound card hardware
    soundCardName = 'Primary Sound Capture Driver (Windows DirectSound)';
    cardID = audiodevinfo(1,soundCardName);

    % define the global object, initialise it and define its properties
    global hexchangedata;
    hexchangedata.count=0;hexchangedata.previousetimea=0;hexchangedata.previousetimeb=0;
    hexchangedata.mmgRecorder_1 = audiorecorder(8000,16,2,cardID); %8kHz,16bit,2channel,devID
    hexchangedata.mmgRecorder_2 = audiorecorder(8000,16,2,cardID); %8kHz,16bit,2channel,devID
    hexchangedata.maintimer = timer('TimerFcn',@timer_Callback,...
                                    'ErrorFcn',@timererr_Callback,...
                                    'ExecutionMode','fixedRate',...
                                    'Period',0.1,...
                                    'BusyMode','error',...
                                    'TasksToExecute',5);

    % start of eternity
    tic;

    % start non blocking recording
    record(hexchangedata.mmgRecorder_1);
    record(hexchangedata.mmgRecorder_2);
    
    % start the timer
    start(hexchangedata.maintimer);

    %% Timer Callback function
    function timer_Callback(~,~)
        hexchangedata.count = hexchangedata.count + 1;

        %Operation for the odd recorder
        if rem(hexchangedata.count,2)== 1            
            if isrecording(hexchangedata.mmgRecorder_1) == 1
                hexchangedata.previousetime = hexchangedata.previousetimeb;
                stop(hexchangedata.mmgRecorder_1);
                hexchangedata.currenttime = toc;
                hexchangedata.previousetimea = hexchangedata.currenttime;
                hexchangedata.analysisdata = getaudiodata(hexchangedata.mmgRecorder_1);
                
                % TODO : Call some function that takes the timing info and
                % the analysis data --> stiches them together
            end
            %begin recording again
            record(hexchangedata.mmgRecorder_1);
        end

        %Operation for the even recorder
        if rem(hexchangedata.count,2)== 0             
            if isrecording(hexchangedata.mmgRecorder_2) == 1
                hexchangedata.previousetime = hexchangedata.previousetimea;
                stop(hexchangedata.mmgRecorder_2);
                hexchangedata.currenttime = toc;
                hexchangedata.previousetimeb = hexchangedata.currenttime;
                hexchangedata.analysisdata = getaudiodata(hexchangedata.mmgRecorder_2);
                
                % TODO : Call some function that takes the timing info and
                % the analysis data --> stiches them together
            end
            %begin recording again
            record(hexchangedata.mmgRecorder_2);
        end
    end

    %% Timer Error Callback function
    function timererr_Callback(~,~)
        hexchangedata.count = hexchangedata.count + 1;

        %Operation for the odd recorder
        if rem(hexchangedata.count,2)== 1            
            if isrecording(hexchangedata.mmgRecorder_1) == 1
                hexchangedata.previousetime = hexchangedata.previousetimeb;
                stop(hexchangedata.mmgRecorder_1);
                hexchangedata.currenttime = toc;
                hexchangedata.previousetimea = hexchangedata.currenttime;
                hexchangedata.analysisdata = getaudiodata(hexchangedata.mmgRecorder_1);
                
                % TODO : Call some function that takes the timing info and
                % the analysis data --> stiches them together
            end
            %begin recording again
            record(hexchangedata.mmgRecorder_1);
        end

        %Operation for the even recorder
        if rem(hexchangedata.count,2)== 0             
            if isrecording(hexchangedata.mmgRecorder_2) == 1
                hexchangedata.previousetime = hexchangedata.previousetimea;
                stop(hexchangedata.mmgRecorder_2);
                hexchangedata.currenttime = toc;
                hexchangedata.previousetimeb = hexchangedata.currenttime;
                hexchangedata.analysisdata = getaudiodata(hexchangedata.mmgRecorder_2);
                
                % TODO : Call some function that takes the timing info and
                % the analysis data --> stiches them together
            end
            %begin recording again
            record(hexchangedata.mmgRecorder_2);
        end
        
        % Start the timer once again cos error handler ensures that the
        % timer stops once the error callback finishes
        start(hexchangedata.maintimer);
    end
end
