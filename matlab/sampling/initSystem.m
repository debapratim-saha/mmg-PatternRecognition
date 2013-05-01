%Initialise the system addresses and create other folders used in this file
rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\Microphone DATA\At Forearm\';
sampleFolder='Thumb23\';
mmgSample='thumb23_backFA_NC.wav';
scriptFolder='using_script\';
fullSamplePath=strcat(rootPath,sampleFolder,mmgSample);    %Path for the complete sample file
scriptFolderPath=strcat(rootPath,sampleFolder,scriptFolder);   %Path for the folder where individual event files will be kept
if exist(scriptFolderPath,'dir')
else
    mkdir(scriptFolderPath);
end
