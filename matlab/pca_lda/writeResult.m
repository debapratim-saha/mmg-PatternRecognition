%This file contains the command to write the "result" variable in CSV
%format to the the custom filename at the path (rootPath\tseriesFolder\resultFolder)
resultFolderPath=strcat(rootPath,tseriesFolder,resultFolder);
if exist(resultFolderPath,'dir')
else
    mkdir(resultFolderPath);
end
csvwrite(strcat(resultFolderPath,strcat('results_pca',num2str(size(principalEigVec,2)),'_19feat.dat')),result);