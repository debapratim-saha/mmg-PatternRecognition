%Initialise the system address
%initSystem

%Read the wave file
[thumb11,fs,nbits] = wavread('../../../../Microphone DATA/At Forearm/Thumb12/Thumb12_F.wav');
sampleLength = length(thumb11);
t=linspace(0,(1/fs)*sampleLength,sampleLength);

%Define the sample window 
sampleWindowLen = 0.4;                          %Lenght of time for each sample (in seconds)
sampleWinDistance = 0.8;                        %Distance between each sample (in seconds)
sampleSize = sampleWindowLen * fs;              %Total number of data points in one sample
sampleMinDist = sampleWinDistance * fs;            %Total number of data points betweek each window

%Evaluate the energy of the system
sampleEnergy = thumb11.^2;

%Plot the sample vs the energy
% plot(t,thumb11);
% grid on; hold all;
% plot(t,sampleEnergy);

windowEnergy(sampleLength,1) = 0;
maxWinEnergy(sampleLength,1) = 0;
localEventStart(sampleLength,1) = 0;  k=1;
for i=1:sampleLength
    if abs(thumb11(i))>0.1
        for j=0:sampleSize
            windowEnergy(i,1) = windowEnergy(i,1) + sampleEnergy(i+j);
        end
    end          
end
normalizedWinEnergy = windowEnergy./max(windowEnergy);

% Detect Local Events based on the local peaks in Window Energy
for i=2:sampleLength
  if normalizedWinEnergy(i,1)>normalizedWinEnergy(i-1,1)
      maxWinEnergy(i,1)=normalizedWinEnergy(i,1);
      localEventStart(k,1)=i; 
  else if localEventStart(k,1) ~= 0
          k=k+1;
      end
  end
end
% hold all;
% plot(t,normalizedWinEnergy);
grid on;hold all;
plot(t,maxWinEnergy);

%Detect Unique Global Event Pointers from the Local Events detected earlier
globEventPointer(k,2)=0;    
sampleBegin=1;    prevSampleEnd=1;
loopCounter=0;    
m=1;
while loopCounter<k
    loopCounter=loopCounter+1;
    
    for i=1:(k-sampleBegin-1)
        if (maxWinEnergy(localEventStart(sampleBegin,1))>maxWinEnergy(localEventStart(sampleBegin+i,1)))
            if (abs(localEventStart(sampleBegin,1)-localEventStart(sampleBegin+i,1))>sampleSize)
                globEventPointer(m,1)=localEventStart(sampleBegin,1);
                sampleBegin = sampleBegin+i;                            %This point is immediate next point from current sample 
                prevSampleEnd = sampleBegin-1;                          %This is the last avaialable point for current sample
                while abs(localEventStart(prevSampleEnd)-localEventStart(sampleBegin))<sampleMinDist          %Keep looking for next datapoint until it is "sampleMinDist" apart                                   
                    sampleBegin=sampleBegin+1;
                end
                loopCounter = sampleBegin;
                m=m+1;
                break;
            end
        else
            sampleBegin = sampleBegin+i;                                %Change your ref point to the bigger data
            loopCounter = sampleBegin;
            break;
        end
    end
end
globEventPointer(:,2)=globEventPointer(:,1)/fs;
