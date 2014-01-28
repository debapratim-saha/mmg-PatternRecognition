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
    SamplesPerFrame = 1000;
    
    % If a filename was given, setup a dsp.AudioFileReader
    if exist('FilePath', 'var')
        Input = dsp.AudioFileReader(FilePath, 'PlayCount', 1, 'SamplesPerFrame', SamplesPerFrame);
        is_live = false;
    % Otherwise, use a dsp.AudioRecorder for live input
    else
        Input = dsp.AudioRecorder('SampleRate', SampleRate);
        is_live = true;
    end
    
    % Setup buffers for use in `extract_window`
    raw = zeros(70,2);
    power = zeros(70,2);
    
    % While IsProcessingAudio == 1
    % This is set in `main_gui`
    while getappdata(0, 'IsProcessingAudio')
        
        % Take a frame from the input (either from a file or from live input)
        frame = step(Input);
        
        % Iterate over each sample in the frame, passing it to
        % `extract_window`
        % FIXME: A good frame is not found for all of the sample WAV files
        for i=1:length(frame)
            [good, raw, power] = extract_window(frame(i,:), raw, power);
        end
        
        % TODO: Initiate processing of good frame in `raw` here
        
        % If `extract_window` signaled a good frame, increment the good
        % frame counter
        if strcmp(good, 'start')
            good_frames = good_frames + 1;
        end
        
        % `drawnow` is required for IsProcessingAudio to be changed inside
        % `main_gui`
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