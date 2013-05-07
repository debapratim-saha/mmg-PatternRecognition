%Read the wave file
[timeSeriesData,fs,nbits] = wavread(fullSamplePath);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  JUST FOR NOW - DELETE IT LATER
sampleLength = length(timeSeriesData);
timeSeriesData1=timeSeriesData(1:sampleLength/4,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Continue from here
sampleLength = length(timeSeriesData1);
t=linspace(0,(1/fs)*sampleLength,sampleLength);

%Define the sample window 
sampleWindowLen = 0.7;                          %Lenght of time for each sample (in seconds)
sampleWinDistance = 0.5;                        %Distance between each sample (in seconds)
sampleSize = sampleWindowLen * fs;              %Total number of data points in one sample
sampleMinDist = sampleWinDistance * fs;         %Total number of data points betweek each window

%Evaluate the energy of the system
sampleEnergy = timeSeriesData1.^2;

%Plot the sample vs the energy
for i=1:numChannels
    subplot(numChannels,1,i);
    plot(t,timeSeriesData1(:,i));
    grid on; hold all;
    %plot(t,sampleEnergy(:,i));
end
tic;
%Determine window energy by summing energy at each point
windowEnergy = zeros(sampleLength,numChannels);
for i=1:sampleLength
    if (abs(timeSeriesData1(i,1))>0.025 || abs(timeSeriesData1(i,2))>0.025) && i+sampleSize<sampleLength
%         for j=0:sampleSize
%             windowEnergy(i,:) = windowEnergy(i,:) + sampleEnergy(i+j,:);
%         end
        windowEnergy(i,:)=sum(sampleEnergy(i:i+sampleSize,:));
    end          
end

%Normalize the window energy by dividing all by the highest energy
normalizedWinEnergy=zeros(sampleLength,numChannels);
for i=1:numChannels
    normalizedWinEnergy(:,i) = windowEnergy(:,i)./max(windowEnergy(:,i));
end

% Detect Local Events based on the local peaks in Window Energy
maxWinEnergy = zeros(sampleLength,numChannels);
localEventStart= zeros(sampleLength,numChannels+1);  k=1;
for i=2:sampleLength
  if normalizedWinEnergy(i,1)>normalizedWinEnergy(i-1,1) || normalizedWinEnergy(i,2)>normalizedWinEnergy(i-1,2)
      maxWinEnergy(i,:)=normalizedWinEnergy(i,:);
      localEventStart(k,:)=[i,normalizedWinEnergy(i,:)]; 
  else if localEventStart(k,1) ~= 0
          k=k+1;
      end
  end
end

%Plot the maxWinEnergy over actual signal
localEventStart(:,4:5)=localEventStart(:,2:3)/fs;
for i=1:numChannels
    subplot(numChannels,1,i);
    hold all;
    plot(t,normalizedWinEnergy(:,i));
    grid on;hold all;
    plot(t,maxWinEnergy(:,i));
end
toc

% %Detect Unique Global Event Pointers from the Local Events detected earlier
% globEventPointer=zeros(k,numChannels+3);    
% sampleBegin=1;    maxThisValue=0; maxThisIndex=0;    
% loopCounter=0;    thisSampleSpan=zeros(k,numChannels+4);
% m=1;j=1;
% while sampleBegin<k
%     loopCounter = loopCounter+1 ;
%     if abs(localEventStart(sampleBegin,1)-localEventStart(sampleBegin+1,1))<sampleSize   || abs(localEventStart(sampleBegin,2)-localEventStart(sampleBegin+1,2))<sampleSize                           %If there is more than one energy peak in current locality, then sampleBegin~=sampleEnd
%         if maxWinEnergy(localEventStart(sampleBegin,1))>maxWinEnergy(localEventStart(sampleBegin+1,1)) 
%             %Find the end of this current sample
%             sampleEnd=sampleBegin+1;
%             while abs(localEventStart(sampleBegin,1)-localEventStart(sampleEnd,1))<sampleSize
%                 sampleEnd=sampleEnd+1;
%             end        
%             sampleEnd=sampleEnd-1;                                     
%             [maxThisValue,maxThisIndex]=max(localEventStart(sampleBegin:sampleEnd,2));  
%             
%             thisSampleSpan(loopCounter,:)=[sampleBegin,sampleEnd,localEventStart(sampleBegin)/fs,localEventStart(sampleEnd)/fs,maxThisValue];
%             if maxThisValue>0.05
%                 globEventPointer(m,1:3)=[localEventStart((maxThisIndex+sampleBegin-1),1),maxThisValue,loopCounter];             %sampleBegin is added because the function "max" returns the index wrt "sampleBegin:sampleEnd"
%                 m=m+1;                                                                                                          
%             end
% 
%             %Find the beginning of next sample
%             sampleBegin=sampleEnd+1;
%             while abs(localEventStart(sampleEnd)-localEventStart(sampleBegin))<sampleMinDist
%                 sampleBegin=sampleBegin+1;
%             end        
%         else
%             sampleBegin=sampleBegin+1;
%         end    
%     else     %For the case when there is only one energy peak in current locality i.e. sampleBegin=sampleEnd
%         maxThisValue=localEventStart(sampleBegin,2);
%         maxThisIndex=1; sampleEnd=sampleBegin;
%         
%         thisSampleSpan(loopCounter,:)=[sampleBegin,sampleEnd,localEventStart(sampleBegin)/fs,localEventStart(sampleEnd)/fs,maxThisValue];
%         if maxThisValue>0.05             %since there is a single energy peak in locality, it should be a big one as compared to the other case
%             globEventPointer(m,1:3)=[localEventStart((maxThisIndex+sampleBegin-1),1),maxThisValue,loopCounter];             %sampleBegin is added because the function "max" returns the index wrt "sampleBegin:sampleEnd"
%             m=m+1;                                                                                                          
%         end
%         
%         %Find the beginning of next sample
%         sampleBegin=sampleEnd+1;
%         while abs(localEventStart(sampleEnd)-localEventStart(sampleBegin))<sampleMinDist
%             sampleBegin=sampleBegin+1;
%         end 
%     end
% end

% globEventPointer(:,4)=globEventPointer(:,1)/fs;
% 
% % Saving *.wav files of each sample
% prePeakDuration=0.05;                                           %Pre peak duration in 's'
% prePeakDist=prePeakDuration*fs;                                 %Pre peak duration in data points
% postPeakDuration=sampleWindowLen - prePeakDuration;             %Post peak duration in 's' 
% postPeakDist=postPeakDuration*fs;                               %Post peak duration in data points
% for i=1:m-1
%     eventPeakPoint=globEventPointer(i,1);
%     eventStart=eventPeakPoint-prePeakDist;
%     eventEnd=eventPeakPoint+postPeakDist-1;
%     
%     eventSample=timeSeriesData(eventStart:eventEnd,1);
%     %filename=strcat(scriptFolderPath,'sample_',num2str(i),'_',num2str(globEventPointer(i,3)),'.wav');
%     filename=strcat(scriptFolderPath,'sample_',num2str(i),'.wav');
%     wavwrite(eventSample,fs,nbits,filename);
% end