function [A_feature] = generateFeatures(A)
%This function generates all the features considered for the current
%problem and bundles all of them in a row vector
%Number of features considered now = 19

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
A_ar7=ar(A,7);                          %Autoregression coeffs order 7

A_feature=[A_immg A_mean A_mad A_var A_sd A_kurt A_skew A_zc A_ssc A_wilson A_rms A_logrms A_ar7.a(2:8)];

function [zc]=zeroCrossing(A)
%This function returns the zero crossing count in a particular data matrix
zc=0;
for i=1:(length(A)-1)
    if(sign(-1*A(i)*A(i+1))== 1)
        zc=zc+1;
    end
end

function [ssc]=slopeSignChange(A)
ssc=0;
for i=1:(length(A)-2)
    if(sign((A(i+1)-A(i))*(A(i+1)-A(i+2)))== 1)
        ssc=ssc+1;
    end
end

function [wa]=wilsonAmp(A)
wa=0;
for i=1:(length(A)-1)
    if((abs(A(i)-A(i+1))<0.05) & (abs(A(i)-A(i+1))>=0.0005))    %Change these values as per need. As of now, these are arbitrary values.
        wa=wa+1;
    end
end 