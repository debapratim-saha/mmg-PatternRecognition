function finalFeatMatrix=parGenFeat(A,Fs)
%This function generates all the features considered for the current
%problem and bundles all of them in a row vector
%Number of features considered now = 19 and Number of Channels = 2

    %Get the number of channels
    nCh=size(A,3);
    sampleSize=size(A,2);
    
    %Get the function handles for each feature
    handles=generateFeatures(A,Fs,sampleSize);
    
    A_feature=zeros(1,16,nCh);
    for i=1:length(handles)-1
        A_feature(:,i,:)=handles{i}(A);
    end
    A_feature(:,10:16,:)=handles{10}(A);
    
    nSamp=size(A_feature,1);
    nFeatPerCh=size(A_feature,2);
    newFeatureMatrix=zeros(nSamp,nFeatPerCh*nCh);
    for ch=1:nCh
        newFeatureMatrix(:,(nFeatPerCh*(ch-1)+1):nFeatPerCh*ch)=A_feature(:,:,ch);
    end
    finalFeatMatrix=newFeatureMatrix;
    
end