%Read the wave file
[timeSeriesData,fs,nbits] = wavread(fullSamplePath);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  JUST FOR NOW - DELETE IT LATER
%  sampleLength = length(timeSeriesData);
%  timeSeriesData1=timeSeriesData(1:sampleLength/2,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Continue from here
sampleLength = length(timeSeriesData);
t=linspace(0,(1/fs)*sampleLength,sampleLength);

%Define the sample window 
sampleWindowLen = 0.7;                          %Lenght of time for each sample (in seconds)
interSampleWinDistance = 0.5;                        %Distance between each sample (in seconds)
sampleSize = sampleWindowLen * fs;              %Total number of data points in one sample
interSampleMinDist = interSampleWinDistance * fs;         %Total number of data points betweek each window

%Evaluate the energy of the system
sampleEnergy = timeSeriesData.^2;

%Plot the sample vs the energy
for i=1:numChannels
    subplot(numChannels,1,i);
    plot(t,timeSeriesData(:,i));
    grid on; hold all;
    plot(t,sampleEnergy(:,i));
end
tic;
%Determine window energy by summing energy at each point
windowEnergy = zeros(sampleLength,numChannels);
for j=1:numChannels
    for i=1:sampleLength
        if abs(timeSeriesData(i,j))>0.025 && i+sampleSize<sampleLength
    %         for j=0:sampleSize
    %             windowEnergy(i,:) = windowEnergy(i,:) + sampleEnergy(i+j,:);
    %         end
            windowEnergy(i,j)=sum(sampleEnergy(i:i+sampleSize,j));
        end    
    end
end

%Normalize the window energy by dividing all by the highest energy
normalizedWinEnergy = windowEnergy./max(max(windowEnergy),[],2);


% Detect Local Events based on the local peaks in Window Energy
maxWinEnergy = zeros(sampleLength,numChannels);
localEventStart= zeros(sampleLength,2,numChannels);    k=ones(numChannels,1);
for j=1:numChannels    
    for i=2:sampleLength
      if normalizedWinEnergy(i,j)>normalizedWinEnergy(i-1,j)
          maxWinEnergy(i,j)=normalizedWinEnergy(i,j);
          localEventStart(k(j),:,j)=[i,normalizedWinEnergy(i,j)];
      else if localEventStart(k(j),1,j) ~= 0
              k(j)=k(j)+1;
          end
      end
    end
end

%Plot the maxWinEnergy over actual signal
%localEventStart(:,3:4,:)=localEventStart(:,1:2,:)/fs;
for i=1:numChannels
    subplot(numChannels,1,i);
    hold all;
    plot(t,normalizedWinEnergy(:,i));
    grid on;hold all;
    plot(t,maxWinEnergy(:,i));
end

%Detect Unique Global Event Pointers from the Local Events detected earlier
globEventPointer=zeros(max(k),3,numChannels);    
thisSampleSpan=zeros(max(k),5,numChannels);
m=ones(numChannels,1);
for i=1:numChannels
    sampleBegin=1;    maxThisValue=0; maxThisIndex=0;    
    loopCounter=0;    
    while sampleBegin<k(i)
        loopCounter = loopCounter+1 ;
        if abs(localEventStart(sampleBegin,1,i)-localEventStart(sampleBegin+1,1,i))<sampleSize                  %If there is more than one energy peak in current locality, then sampleBegin~=sampleEnd
            if maxWinEnergy(localEventStart(sampleBegin,1,i),i)>maxWinEnergy(localEventStart(sampleBegin+1,1,i),i) 
                %Find the end of this current sample
                sampleEnd=sampleBegin+1;
                while abs(localEventStart(sampleBegin,1,i)-localEventStart(sampleEnd,1,i))<sampleSize
                    sampleEnd=sampleEnd+1;
                end        
                sampleEnd=sampleEnd-1;                                     
                [maxThisValue,maxThisIndex]=max(localEventStart(sampleBegin:sampleEnd,2,i));  

                %thisSampleSpan(loopCounter,:)=[sampleBegin,sampleEnd,localEventStart(sampleBegin)/fs,localEventStart(sampleEnd)/fs,maxThisValue];
                if maxThisValue>0.05
                    globEventPointer(m(i),:,i)=[localEventStart((maxThisIndex+sampleBegin-1),1,i),maxThisValue,loopCounter];             %sampleBegin is added because the function "max" returns the index wrt "sampleBegin:sampleEnd"
                    m(i)=m(i)+1;                                                                                                          
                end

                %Find the beginning of next sample
                sampleBegin=sampleEnd+1;
                while abs(localEventStart(sampleEnd,1,i)-localEventStart(sampleBegin,1,i))<interSampleMinDist
                    sampleBegin=sampleBegin+1;
                end        
            else
                sampleBegin=sampleBegin+1;
            end    
        else     %For the case when there is only one energy peak in current locality i.e. sampleBegin=sampleEnd
            maxThisValue=localEventStart(sampleBegin,2,i);
            maxThisIndex=1; sampleEnd=sampleBegin;

            %thisSampleSpan(loopCounter,:)=[sampleBegin,sampleEnd,localEventStart(sampleBegin)/fs,localEventStart(sampleEnd)/fs,maxThisValue];
            if maxThisValue>0.05             %since there is a single energy peak in locality, it should be a big one as compared to the other case
                globEventPointer(m(i),:,i)=[localEventStart((maxThisIndex+sampleBegin-1),1,i),maxThisValue,loopCounter];             %sampleBegin is added because the function "max" returns the index wrt "sampleBegin:sampleEnd"
                m(i)=m(i)+1;                                                                                                          
            end

            %Find the beginning of next sample
            sampleBegin=sampleEnd+1;
            while abs(localEventStart(sampleEnd,1,i)-localEventStart(sampleBegin,1,i))<interSampleMinDist
                sampleBegin=sampleBegin+1;
            end 
        end
    end
end

%Choose the major identifier of an event among the channel events by testing 
%which event among the channels starts first and what is its amplitude
%This is specialised for 2 channel operation. For higher channel count, 
%need to check and modify the code.
unifiedGlobEventPointer=zeros(max(m),1);
for i=1:max(m)
    if abs(diff(globEventPointer(i,1,:)))<sampleSize     
        %Case where the individual channel events correspond to the same actual event
        [maxAmp,maxAmpIndex]    =   max(globEventPointer(i,2,:));                                     %find the max amplitude value among the two channels
        [minTime,minTimeIndex]  =   min(globEventPointer(i,1,:));                                     %find the channel where local event starts first among the two channels
        if maxAmpIndex ~= minTimeIndex  && globEventPointer(i,2,minTimeIndex)>0.2*maxAmp              %Means the channel with max amplitude is not where event starts first, so check if the amp at the point of event start is atleast greater than 20% of maxAmp
            unifiedGlobEventPointer(i)  =   globEventPointer(i,1,maxAmpIndex);
        else
            unifiedGlobEventPointer(i)  =   globEventPointer(i,1,minTimeIndex);
        end
    else
        %Case where one of the channels do not have sufficient energy for
        %this particular event
        [minTime,minTimeIndex]  =   min(globEventPointer(i,1,:));
        [maxTime,maxTimeIndex]  =   max(globEventPointer(i,1,:));
        unifiedGlobEventPointer(i)  =   globEventPointer(i,1,minTimeIndex);
        globEventPointer(i:max(k),:,maxTimeIndex)=[[0 0 0];globEventPointer(i:(max(k)-1),:,maxTimeIndex)];        
    end       
end
toc

% % JUST FOR EXPERIMENTS - To check the values of globEventPointer - DELETE IN PRODUCTION CODE
% globEventPointer_1=vpa(globEventPointer(:,:,1));
% globEventPointer_2=vpa(globEventPointer(:,:,2));

% globEventPointer(:,4)=globEventPointer(:,1)/fs;

% Saving *.wav files of each sample
prePeakDuration=0.05;                                           %Pre peak duration in 's'
prePeakDist=prePeakDuration*fs;                                 %Pre peak duration in data points
postPeakDuration=sampleWindowLen - prePeakDuration;             %Post peak duration in 's' 
postPeakDist=postPeakDuration*fs;                               %Post peak duration in data points
for i=1:max(m)-1
    eventPeakPoint=unifiedGlobEventPointer(i,1);
    eventStart=eventPeakPoint-prePeakDist;
    eventEnd=eventPeakPoint+postPeakDist-1;
    
    eventSample=timeSeriesData(eventStart:eventEnd,1);
    %filename=strcat(scriptFolderPath,'sample_',num2str(i),'_',num2str(globEventPointer(i,3)),'.wav');
    filename=strcat(scriptFolderPath,'sample_',num2str(i),'.wav');
    wavwrite(eventSample,fs,nbits,filename);
end