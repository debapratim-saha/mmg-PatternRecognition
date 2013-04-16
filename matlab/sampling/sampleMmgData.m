%Read the wave file
[timeSeriesData,fs,nbits] = wavread(fullSamplePath);
sampleLength = length(timeSeriesData);
t=linspace(0,(1/fs)*sampleLength,sampleLength);

%Define the sample window 
sampleWindowLen = 0.4;                          %Lenght of time for each sample (in seconds)
sampleWinDistance = 0.4;                        %Distance between each sample (in seconds)
sampleSize = sampleWindowLen * fs;              %Total number of data points in one sample
sampleMinDist = sampleWinDistance * fs;         %Total number of data points betweek each window

%Evaluate the energy of the system
sampleEnergy = timeSeriesData.^2;

%Plot the sample vs the energy
plot(t,timeSeriesData);
grid on; hold all;
%plot(t,sampleEnergy);

windowEnergy = zeros(sampleLength,1);
for i=1:sampleLength
    if abs(timeSeriesData(i))>0.1
        for j=0:sampleSize
            windowEnergy(i,1) = windowEnergy(i,1) + sampleEnergy(i+j,1);
        end
    end          
end
normalizedWinEnergy = windowEnergy./max(windowEnergy);

% Detect Local Events based on the local peaks in Window Energy
maxWinEnergy = zeros(sampleLength,1);
localEventStart= zeros(sampleLength,2);  k=1;
for i=2:sampleLength
  if normalizedWinEnergy(i,1)>normalizedWinEnergy(i-1,1)
      maxWinEnergy(i,1)=normalizedWinEnergy(i,1);
      localEventStart(k,:)=[i,normalizedWinEnergy(i,1)]; 
  else if localEventStart(k,1) ~= 0
          k=k+1;
      end
  end
end
localEventStart(:,3)=localEventStart(:,1)/fs;
hold all;
plot(t,normalizedWinEnergy);
grid on;hold all;
plot(t,maxWinEnergy);

%Detect Unique Global Event Pointers from the Local Events detected earlier
globEventPointer=zeros(k,4);    
sampleBegin=1;    maxThisValue=0; maxThisIndex=0;    
loopCounter=0;    thisSampleSpan=zeros(k,5);
m=1;j=1;
while sampleBegin<k-1
    loopCounter = loopCounter+1 ;
    if abs(localEventStart(sampleBegin,1)-localEventStart(sampleBegin+1,1))<sampleSize                              %If there is more than one energy peak in current locality, then sampleBegin~=sampleEnd
        if maxWinEnergy(localEventStart(sampleBegin,1))>maxWinEnergy(localEventStart(sampleBegin+1,1)) 
            %Find the end of this current sample
            sampleEnd=sampleBegin+1;
            while abs(localEventStart(sampleBegin,1)-localEventStart(sampleEnd,1))<sampleSize
                sampleEnd=sampleEnd+1;
            end        
            sampleEnd=sampleEnd-1;                                     
            [maxThisValue,maxThisIndex]=max(localEventStart(sampleBegin:sampleEnd,2));  
            
            thisSampleSpan(loopCounter,:)=[sampleBegin,sampleEnd,localEventStart(sampleBegin)/fs,localEventStart(sampleEnd)/fs,maxThisValue];
            if maxThisValue>0.05
                globEventPointer(m,1:3)=[localEventStart((maxThisIndex+sampleBegin-1),1),maxThisValue,loopCounter];             %sampleBegin is added because the function "max" returns the index wrt "sampleBegin:sampleEnd"
                m=m+1;                                                                                                          
            end

            %Find the beginning of next sample
            sampleBegin=sampleEnd+1;
            while abs(localEventStart(sampleEnd)-localEventStart(sampleBegin))<sampleMinDist
                sampleBegin=sampleBegin+1;
            end        
        else
            sampleBegin=sampleBegin+1;
        end    
    else     %For the case when there is only one energy peak in current locality i.e. sampleBegin=sampleEnd
        maxThisValue=localEventStart(sampleBegin,2);
        maxThisIndex=1; sampleEnd=sampleBegin;
        
        thisSampleSpan(loopCounter,:)=[sampleBegin,sampleEnd,localEventStart(sampleBegin)/fs,localEventStart(sampleEnd)/fs,maxThisValue];
        if maxThisValue>0.1             %since there is a single energy peak in locality, it should be a big one as compared to the other case
            globEventPointer(m,1:3)=[localEventStart((maxThisIndex+sampleBegin-1),1),maxThisValue,loopCounter];             %sampleBegin is added because the function "max" returns the index wrt "sampleBegin:sampleEnd"
            m=m+1;                                                                                                          
        end
        
        %Find the beginning of next sample
        sampleBegin=sampleEnd+1;
        while abs(localEventStart(sampleEnd)-localEventStart(sampleBegin))<sampleMinDist
            sampleBegin=sampleBegin+1;
        end 
    end
end

globEventPointer(:,4)=globEventPointer(:,1)/fs;

% Saving *.wav files of each sample
prePeakDuration=0.05;                                           %Pre peak duration in 's'
prePeakDist=prePeakDuration*fs;                                 %Pre peak duration in data points
postPeakDuration=sampleWindowLen - prePeakDuration;             %Post peak duration in 's' 
postPeakDist=postPeakDuration*fs;                               %Post peak duration in data points
for i=1:m-1
    eventPeakPoint=globEventPointer(i,1);
    eventStart=eventPeakPoint-prePeakDist;
    eventEnd=eventPeakPoint+postPeakDist;
    
    eventSample=timeSeriesData(eventStart:eventEnd,1);
    filename=strcat(scriptFolderPath,'sample_',num2str(i),'_',num2str(globEventPointer(i,3)),'.wav');
    wavwrite(eventSample,fs,nbits,filename);
end