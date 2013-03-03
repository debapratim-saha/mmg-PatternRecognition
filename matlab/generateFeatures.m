function [A_feature] = generateFeatures(A)
%This function generates all the features considered for the current
%problem and bundles all of them in a row vector
%Total Features considered now = 7
A_mad=mad(A);
A_sd=std(A);
A_kurt=kurtosis(A);
A_skew=skewness(A);
A_zc=zeroCrossing(A);
A_ssc=slopeSignChange(A);
A_rms=rms(A);

A_feature=[A_mad A_sd A_kurt A_skew A_zc A_ssc A_rms];


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