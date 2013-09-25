%This file contains the command to write the "result" variable in CSV
%format to the the custom filename at the path (rootPath\tseriesFolder\resultFolder)
if exist(resultPath,'dir')
else
    mkdir(resultPath);
end
switch resultWriteVar
    case 'QDA'
        csvwrite(strcat(resultPath,strcat('results_fisher',num2str(nFisherReducedFeat),'_pca',num2str(nPcaReducedFeat),'_feat',num2str(numberOfFeatures),'_samples',num2str(totalSamples),'.dat')),loocvResult);
    case 'KNN'
        csvwrite(strcat(resultPath,strcat('knnresults_k',num2str(knn),'_fisher',num2str(nFisherReducedFeat),'_pca',num2str(nPcaReducedFeat),'_feat',num2str(numberOfFeatures),'_samples',num2str(totalSamples),'.dat')),loocvResultKnn);
    otherwise
        csvwrite(strcat(resultPath,'results'));
end