%Initialise the system addresses and create other folders used in this file
% rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\Microphone DATA\At Forearm\SELF\';
% sampleFolder='Thumb29\';
% mmgSample='thumb29_dual_NC.wav';

rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\Microphone DATA\At Forearm\USER\UserD\';
sampleFolder='Sample2\';
mmgSample='user4_dual_4motion_2.wav';
scriptFolder='using_script\';
numChannels=2;
fullSamplePath=strcat(rootPath,sampleFolder,mmgSample);    %Path for the complete sample file
scriptFolderPath=strcat(rootPath,sampleFolder,scriptFolder);   %Path for the folder where individual event files will be kept
if exist(scriptFolderPath,'dir')
else
    mkdir(scriptFolderPath);
end
