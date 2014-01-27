%% Init the folder structure
rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\CodeBase\mmg-PatternRecognition\matlab\';
sampleFolder='automation\';
mmgSample='user2_dual_4motion_2.wav';
scriptFolder='using_script\';

numChannels=2;
fullSamplePath=strcat(rootPath,sampleFolder,mmgSample);    %Path for the complete sample file
scriptFolderPath=strcat(rootPath,sampleFolder,scriptFolder);   %Path for the folder where individual event files will be kept
if exist(scriptFolderPath,'dir')
else
    mkdir(scriptFolderPath);
end

%% Find the correct window limits for samples
%Read the wave file and downsample it
[origMMGdata,fs,nbits] = wavread(fullSamplePath);
lowSampleFreq=100; sPeriod=1/lowSampleFreq; % Downsample frequency in Hz
timeSeriesData=downsample(origMMGdata,fs/lowSampleFreq);

% Continue from here
sampleLength = length(timeSeriesData);
t=linspace(0,(1/lowSampleFreq)*sampleLength,sampleLength);

% Define buffers and windowLimits
raw_buf = zeros(70,2);
pow_buf = zeros(70,2);
windowLimits = zeros(1,2);
sampleCount = 0; i = 1;

while i < (sampleLength-50)
    [win_status,raw_buf,pow_buf]=extract_window(timeSeriesData(i,:),raw_buf,pow_buf);
    
    % Plot the window --> For debug purposes
%     if i==146
%         subplot(3,1,1)
%         plot(raw_buf);grid on;
%         subplot(3,1,2)
%         plot(pow_buf);grid on;
%         subplot(3,1,3)
%         plot([[0 0];diff(pow_buf)]/sPeriod);grid on;
%         break;
%     end

    if strcmp(win_status,'start')==1
        sampleCount=sampleCount+1;
%         windowLimits(sampleCount,:)=[i-winStartOffset,i-winStartOffset+60];
        windowLimits(sampleCount,:)=[i-15,i+45];
        
        % Jump to the end of current sample and reset all buffers
%         i=i-winStartOffset+61;
        i=i+45;
        raw_buf = zeros(70,2);
        pow_buf = zeros(70,2);
    else
        i=i+1;
    end
end
