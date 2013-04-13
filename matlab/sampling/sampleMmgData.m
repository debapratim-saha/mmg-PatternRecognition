%Initialise the system address
%initSystem

%Read the wave file
[thumb11,fs,nbits] = wavread('../../../../Microphone DATA/At Forearm/Thumb10/Thumb10_F.wav');
sampleLength = length(thumb11);
t=linspace(0,(1/fs)*sampleLength,sampleLength);

%Define the sample window 
sampleWindowLen = 0.4;                          %Lenght of time for each sample (in seconds)
sampleWinDistance = 0.4;                        %Distance between each sample (in seconds)
sampleSize = sampleWindowLen * fs;              %Total number of data points in one sample
sampleMinDist = sampleWinDistance * fs;            %Total number of data points betweek each window

%Evaluate the energy of the system
sampleEnergy = thumb11.^2;

%Plot the sample vs the energy
plot(t,thumb11);
grid on; hold all;
plot(t,sampleEnergy);

windowEnergy = zeros(sampleLength,1);
for i=1:sampleLength
    if abs(thumb11(i))>0.1
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
globEventPointer=zeros(k,3);    
sampleBegin=1;    maxThisValue=0; maxThisIndex=0;    
loopCounter=1;    thisSampleSpan=zeros(k,3);
m=1;j=1;
while sampleBegin<k-1
    loopCounter = loopCounter+1 ;
    if maxWinEnergy(localEventStart(sampleBegin,1))>maxWinEnergy(localEventStart(sampleBegin+j,1))
        %j=j+1;
        %Find the end of this current sample
        sampleEnd=sampleBegin+1;
        while abs(localEventStart(sampleBegin,1)-localEventStart(sampleEnd,1))<sampleSize
            sampleEnd=sampleEnd+1;
        end        
        sampleEnd=sampleEnd-1;
        [maxThisValue,maxThisIndex]=max(localEventStart(sampleBegin:sampleEnd,2));  
        thisSampleSpan(loopCounter,:)=[localEventStart(sampleBegin)/fs,localEventStart(sampleEnd)/fs,maxThisValue];
        if maxThisValue>0.07
            globEventPointer(m,1:2)=[localEventStart((maxThisIndex+sampleBegin-1),1),maxThisValue];             %sampleBegin is added because the function "max" 
            m=m+1;                                                                                              %returns the index wrt "sampleBegin:sampleEnd"
        end
        
        %Find the beginning of next sample
        sampleBegin=sampleEnd+1;
        while abs(localEventStart(sampleEnd)-localEventStart(sampleBegin))<sampleMinDist
            sampleBegin=sampleBegin+1;
        end        
    else
        sampleBegin=sampleBegin+j;
        j=1;
    end    
end
    
globEventPointer(:,3)=globEventPointer(:,1)/fs;
