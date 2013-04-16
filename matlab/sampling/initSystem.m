%Initialise the system addresses and create other folders used in this file
rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\Microphone DATA\At Forearm\';
sampleFolder='Thumb12\';
mmgSample='Thumb12_F.wav';
scriptFolder='using_script\';
fullSamplePath=strcat(rootPath,sampleFolder,mmgSample);    %Path for the complete sample file
scriptFolderPath=strcat(rootPath,sampleFolder,scriptFolder);   %Path for the folder where individual event files will be kept
if exist(scriptFolderPath,'dir')
else
    mkdir(scriptFolderPath);
end
