function [A_feature_final] = generateFeatures(A,Fs,sampleSize)
%This function generates all the features considered for the current
%problem and bundles all of them in a row vector
%Number of features considered now = 19 and Number of Channels = 2

nCh=size(A,3);

A_immg=sum(abs(A));                     %Integrated abs MMG amplitude
A_mean=mean(abs(A));                    %Mean of abs amplitude
A_mad=mad(A);                           %Mean of abs-deviation from mean
A_var=var(A);                           %Variance of data
A_sd=std(A);
A_kurt=kurtosis(A);
A_skew=skewness(A);
A_zc=zeroCrossing(A);
A_ssc=slopeSignChange(A);
A_wilson=wilsonAmp(A);
A_rms=rms(A);
A_logrms=log(A_rms);
A_wlen=wlen(A);
A_fmedian=fmedian(A,Fs,sampleSize);
A_fmean=fmean(A,Fs,sampleSize);

%Calculate the 7th order AR coefficients for all channels
A_ar7_coeff=zeros(1,7,nCh);
for i=1:nCh
    A_ar7=ar(A(:,:,i),7);                          %Autoregression coeffs order 7 for channel i
    A_ar7_coeff(1,:,i)=A_ar7.a(2:8);
end

%Calculate cepstrum coefficient from AR coeff

    
%% Final FEATURE_MATRIX for the input matrix 
% A_feature=[A_immg A_mean A_mad A_var A_sd A_kurt A_skew A_zc A_ssc A_wilson A_rms A_logrms A_ar7_coeff];
 A_feature=[A_immg A_mad A_var A_zc A_wilson A_rms A_ar7_coeff A_wlen A_fmedian A_fmean];
nSamp=size(A_feature,1);
nFeatPerCh=size(A_feature,2);
nCh=size(A_feature,3);
newFeatureMatrix=zeros(nSamp,nFeatPerCh*nCh);
for i=1:nCh
    newFeatureMatrix(:,(nFeatPerCh*(i-1)+1):nFeatPerCh*i)=A_feature(:,:,i);
end
A_feature_final=newFeatureMatrix;


function [zc]=zeroCrossing(A)
%This function returns the zero crossing count in a particular data matrix 
%on all of its channels
nCh=size(A,3);zc=zeros(1,1,nCh);count=0;
for i=1:nCh
    for j=1:(size(A,2)-1)
        if(sign(-1*A(1,j,i)*A(1,j+1,i))== 1)
            count=count+1;
        end
    end
    zc(1,1,i)=count;
    count=0;
end

function [ssc]=slopeSignChange(A)
%This function calculates the slope sign change in a particular data matrix
%on all of its channels
nCh=size(A,3);ssc=zeros(1,1,nCh);count=0;
for i=1:nCh
    for j=1:(size(A,2)-2)
        if(sign((A(1,j+1,i)-A(1,j,i))*(A(1,j+1,i)-A(1,j+2,i)))== 1)
            count=count+1;
        end
    end
    ssc(1,1,i)=count;
    count=0;
end

function [wa]=wilsonAmp(A)
%This function calculates the wilson's amplitude in a particular data matrix
%on all of its channels. The threshold value is arbitrary as of now.
nCh=size(A,3);wa=zeros(1,1,nCh);count=0;
for i=1:nCh
    for j=1:(size(A,2)-1)
        if((abs(A(1,j,i)-A(1,j+1,i))<0.05) && (abs(A(1,j,i)-A(1,j+1,i))>=0.000005))    %Change these values as per need. As of now, these are arbitrary values. [Should be >=0.001]
            count=count+1;
        end
    end 
    wa(1,1,i)=count;
    count=0;
end

function [wflen]=wlen(A)
%This function calculates the waveform length of the given MMG sample using
%the formula wlen=sum(|x(i)-x(i-1)|)
nCh=size(A,3);wflen=zeros(1,1,nCh);
for i=1:nCh
   wflen(1,1,i)=sum(abs(diff(A(:,:,i))));
end

function [fmed]=fmedian(A,Fs,sampleSize)
%This function finds the median frequency of the given MMG sample
nCh=size(A,3);fmed=zeros(1,1,nCh);
t=(0:sampleSize-1)/Fs;
nfft=2^nextpow2(sampleSize);
f = Fs/2*linspace(0,1,nfft/2+1);
for i=1:nCh
    %compute fft
    x1=fft(A(:,:,i),nfft)/sampleSize; 

    % Make the psd object
    psd_x1=abs(x1).^2/(sampleSize*Fs);

    % Create a single-sided spectrum
    Hpsd = dspdata.psd(psd_x1(1:length(psd_x1)/2),'Fs',Fs);  

    % Find median frequency
    totalPower=avgpower(Hpsd,[0,100]);    j=0;
    while (avgpower(Hpsd,[0,j]) <= 0.5*totalPower)
        j=j+1;
    end
    
    % Store the MDF for this channel
    fmed(1,1,i)=j;
end

function [fmn]=fmean(A,Fs,sampleSize)
%This function finds the mean frequency of the given MMG sample
nCh=size(A,3);fmn=zeros(1,1,nCh);
t=(0:sampleSize-1)/Fs;
nfft=2^nextpow2(sampleSize);
f = Fs/2*linspace(0,1,nfft/2+1);
for i=1:nCh
    %compute fft
    x1=fft(A(:,:,i),nfft)/sampleSize; 

    % Make the psd object
    psd_x1=abs(x1).^2/(sampleSize*Fs);

    % Create a single-sided spectrum
    Hpsd = dspdata.psd(psd_x1(1:length(psd_x1)/2),'Fs',Fs);  
    
    % Calculate the mean power frequency
    % Find mean frequency power
    freqStep=1;  maxFreq=100;   
    numerator=zeros(maxFreq/freqStep,1);
    for j=0:freqStep:maxFreq
        numerator(j+1,1)=avgpower(Hpsd,[j,j+freqStep])*(j+0.5*freqStep);
    end
    fmn(1,1,i)=sum(numerator,1)/avgpower(Hpsd,[0,100]);
end



