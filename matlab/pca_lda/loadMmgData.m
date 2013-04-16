function [trainingData,group,testData]=loadMmgData()
%This function loads all the MMG data formatted as follows -
%row    = new sample and
%column = sample data

%Initialise the sample root addresse
rootPath= 'E:\VIRGINIA TECH STUDIES\DISIS-GA\WII-GLOVE\Microphone DATA\At Forearm\';

% [thumb3_1,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_1.wav');
% [thumb3_2,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_2.wav');
% [thumb3_3,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_3.wav');
% [thumb3_4,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_4.wav');
% [thumb3_5,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_5.wav');
% [thumb3_6,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_6.wav');
% [thumb3_7,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_7.wav');
% [thumb3_8,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_8.wav');
% 
% thumb3_1 = transpose(thumb3_1);
% thumb3_2 = transpose(thumb3_2);
% thumb3_3 = transpose(thumb3_3);
% thumb3_4 = transpose(thumb3_4);
% thumb3_5 = transpose(thumb3_5);
% thumb3_6 = transpose(thumb3_6);
% thumb3_7 = transpose(thumb3_7);
% thumb3_8 = transpose(thumb3_8);
% trainingData = [thumb3_3;thumb3_5;thumb3_7;
%                 thumb3_4;thumb3_2;thumb3_6];
% testData = [thumb3_8];

% %Define the groups for the data
% group=[1;1;1;2;2;2];

% [thumb5_1,fs,nbits] = wavread('./At Forearm/Thumb5/Thumb5_1.wav');
% [thumb5_2,fs,nbits] = wavread('./At Forearm/Thumb5/Thumb5_2.wav');
% [thumb5_3,fs,nbits] = wavread('./At Forearm/Thumb5/Thumb5_3.wav');
% [thumb5_4,fs,nbits] = wavread('./At Forearm/Thumb5/Thumb5_4.wav');
% [thumb5_5,fs,nbits] = wavread('./At Forearm/Thumb5/Thumb5_5.wav');
% [thumb5_6,fs,nbits] = wavread('./At Forearm/Thumb5/Thumb5_6.wav');
% [thumb5_7,fs,nbits] = wavread('./At Forearm/Thumb5/Thumb5_7.wav');
% 
% thumb5_1 = transpose(thumb5_1);
% thumb5_2 = transpose(thumb5_2);
% thumb5_3 = transpose(thumb5_3);
% thumb5_4 = transpose(thumb5_4);
% thumb5_5 = transpose(thumb5_5);
% thumb5_6 = transpose(thumb5_6);
% thumb5_7 = transpose(thumb5_7);
% 
% trainingData = [thumb5_7;thumb5_1;thumb5_3;
%                 thumb5_6;thumb5_4];
% testData = [thumb5_2];
% 
% %Define the groups for the data
% group=[1;1;1;2;2];
% 
% [thumb6_1,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_1.wav');
% [thumb6_2,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_2.wav');
% [thumb6_3,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_3.wav');
% [thumb6_4,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_4.wav');
% [thumb6_5,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_5.wav');
% [thumb6_6,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_6.wav');
% [thumb6_7,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_7.wav');
% [thumb6_8,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_8.wav');
% [thumb6_9,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_9.wav');
% [thumb6_10,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_10.wav');
% [thumb6_11,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_11.wav');
% [thumb6_12,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_12.wav');
% 
% thumb6_1 = transpose(thumb6_1);
% thumb6_2 = transpose(thumb6_2);
% thumb6_3 = transpose(thumb6_3);
% thumb6_4 = transpose(thumb6_4);
% thumb6_5 = transpose(thumb6_5);
% thumb6_6 = transpose(thumb6_6);
% thumb6_7 = transpose(thumb6_7);
% thumb6_8 = transpose(thumb6_8);
% thumb6_9 = transpose(thumb6_9);
% thumb6_10 = transpose(thumb6_10);
% thumb6_11 = transpose(thumb6_11);
% thumb6_12 = transpose(thumb6_12);
% 
% trainingData = [thumb6_7;thumb6_5;thumb6_11;thumb6_1;thumb6_3;
%                 thumb6_12;thumb6_4;thumb6_2;thumb6_6;thumb6_10];
% testData = [thumb6_12];
% 
% %Define the groups for the data
% group=[1;1;1;1;1;
%        2;2;2;2;2];
% 
% [thumb7_1,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_1.wav');
% [thumb7_2,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_2.wav');
% [thumb7_3,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_3.wav');
% [thumb7_4,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_4.wav');
% [thumb7_5,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_5.wav');
% [thumb7_6,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_6.wav');
% [thumb7_7,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_7.wav');
% [thumb7_8,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_8.wav');
% [thumb7_9,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_9.wav');
% [thumb7_10,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_10.wav');
% [thumb7_11,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_11.wav');
% [thumb7_12,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_12.wav');
% [thumb7_13,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_13.wav');
% [thumb7_14,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_14.wav');
% [thumb7_15,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_15.wav');
% [thumb7_16,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_16.wav');
% [thumb7_17,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_17.wav');
% [thumb7_18,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_18.wav');
% [thumb7_19,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_19.wav');
% [thumb7_20,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_20.wav');
% [thumb7_21,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_21.wav');
% [thumb7_22,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_22.wav');
% [thumb7_23,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_23.wav');
% [thumb7_24,fs,nbits] = wavread('./At Forearm/Thumb7/Thumb7_24.wav');
% 
% thumb7_1 = transpose(thumb7_1);
% thumb7_2 = transpose(thumb7_2);
% thumb7_3 = transpose(thumb7_3);
% thumb7_4 = transpose(thumb7_4);
% thumb7_5 = transpose(thumb7_5);
% thumb7_6 = transpose(thumb7_6);
% thumb7_7 = transpose(thumb7_7);
% thumb7_8 = transpose(thumb7_8);
% thumb7_9 = transpose(thumb7_9);
% thumb7_10 = transpose(thumb7_10);
% thumb7_11 = transpose(thumb7_11);
% thumb7_12 = transpose(thumb7_12);
% thumb7_13 = transpose(thumb7_13);
% thumb7_14 = transpose(thumb7_14);
% thumb7_15 = transpose(thumb7_15);
% thumb7_16 = transpose(thumb7_16);
% thumb7_17 = transpose(thumb7_17);
% thumb7_18 = transpose(thumb7_18);
% thumb7_19 = transpose(thumb7_19);
% thumb7_20 = transpose(thumb7_20);
% thumb7_21 = transpose(thumb7_21);
% thumb7_22 = transpose(thumb7_22);
% thumb7_23 = transpose(thumb7_23);
% thumb7_24 = transpose(thumb7_24);
% 
% trainingData = [thumb7_15;thumb7_13;thumb7_17;thumb7_21;thumb7_19;thumb7_11;
%                 thumb7_2;thumb7_8;thumb7_4;thumb7_6;thumb7_10;thumb7_12];
% testData = [thumb7_18];
% 
% %Define the groups for the data
% group=[1;1;1;1;1;1;
%        2;2;2;2;2;2];
% 
% [thumb8_1,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_1.wav');
% [thumb8_2,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_2.wav');
% [thumb8_3,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_3.wav');
% [thumb8_4,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_4.wav');
% [thumb8_5,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_5.wav');
% [thumb8_6,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_6.wav');
% [thumb8_7,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_7.wav');
% [thumb8_8,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_8.wav');
% [thumb8_9,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_9.wav');
% [thumb8_10,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_10.wav');
% [thumb8_11,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_11.wav');
% [thumb8_12,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_12.wav');
% [thumb8_13,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_13.wav');
% [thumb8_14,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_14.wav');
% [thumb8_15,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_15.wav');
% [thumb8_16,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_16.wav');
% [thumb8_17,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_17.wav');
% [thumb8_18,fs,nbits] = wavread('./At Forearm/Thumb8/Thumb8_18.wav');
% 
% thumb8_1 = transpose(thumb8_1);
% thumb8_2 = transpose(thumb8_2);
% thumb8_3 = transpose(thumb8_3);
% thumb8_4 = transpose(thumb8_4);
% thumb8_5 = transpose(thumb8_5);
% thumb8_6 = transpose(thumb8_6);
% thumb8_7 = transpose(thumb8_7);
% thumb8_8 = transpose(thumb8_8);
% thumb8_9 = transpose(thumb8_9);
% thumb8_10 = transpose(thumb8_10);
% thumb8_11 = transpose(thumb8_11);
% thumb8_12 = transpose(thumb8_12);
% thumb8_13 = transpose(thumb8_13);
% thumb8_14 = transpose(thumb8_14);
% thumb8_15 = transpose(thumb8_15);
% thumb8_16 = transpose(thumb8_16);
% thumb8_17 = transpose(thumb8_17);
% thumb8_18 = transpose(thumb8_18);
% 
% trainingData = [thumb8_7;thumb8_5;thumb8_9;thumb8_1;thumb8_3;
%                 thumb8_4;thumb8_2;thumb8_8;thumb8_10;thumb8_6];
% testData = [thumb8_13];
% 
% %Define the groups for the data
% group=[1;1;1;1;1;
%        2;2;2;2;2];

% [thumb9_1,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_1.wav');
% [thumb9_2,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_2.wav');
% [thumb9_3,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_3.wav');
% [thumb9_4,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_4.wav');
% [thumb9_5,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_5.wav');
% [thumb9_6,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_6.wav');
% [thumb9_7,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_7.wav');
% [thumb9_8,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_8.wav');
% [thumb9_9,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_9.wav');
% [thumb9_10,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_10.wav');
% [thumb9_11,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_11.wav');
% [thumb9_12,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_12.wav');
% [thumb9_13,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_13.wav');
% [thumb9_14,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_14.wav');
% [thumb9_15,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_15.wav');
% [thumb9_16,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_16.wav');
% [thumb9_17,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_17.wav');
% [thumb9_18,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_18.wav');
% [thumb9_19,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_19.wav');
% [thumb9_20,fs,nbits] = wavread('./At Forearm/Thumb9/Thumb9_20.wav');
% 
% thumb9_1 = transpose(thumb9_1);
% thumb9_2 = transpose(thumb9_2);
% thumb9_3 = transpose(thumb9_3);
% thumb9_4 = transpose(thumb9_4);
% thumb9_5 = transpose(thumb9_5);
% thumb9_6 = transpose(thumb9_6);
% thumb9_7 = transpose(thumb9_7);
% thumb9_8 = transpose(thumb9_8);
% thumb9_9 = transpose(thumb9_9);
% thumb9_10 = transpose(thumb9_10);
% thumb9_11 = transpose(thumb9_11);
% thumb9_12 = transpose(thumb9_12);
% thumb9_13 = transpose(thumb9_13);
% thumb9_14 = transpose(thumb9_14);
% thumb9_15 = transpose(thumb9_15);
% thumb9_16 = transpose(thumb9_16);
% thumb9_17 = transpose(thumb9_17);
% thumb9_18 = transpose(thumb9_18);
% thumb9_19 = transpose(thumb9_19);
% thumb9_20 = transpose(thumb9_20);
% 
% trainingData = [thumb9_5;thumb9_3;thumb9_7;thumb9_1;thumb9_9;
%                 thumb9_2;thumb9_8;thumb9_4;thumb9_6;thumb9_10];
% testData = [thumb9_11];
% 
% %Define the groups for the data
% group=[1;1;1;1;1;
%        2;2;2;2;2];
   
% [thumb10_1,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_1.wav');
% [thumb10_2,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_2.wav');
% [thumb10_3,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_3.wav');
% [thumb10_4,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_4.wav');
% [thumb10_5,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_5.wav');
% [thumb10_6,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_6.wav');
% [thumb10_7,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_7.wav');
% [thumb10_8,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_8.wav');
% [thumb10_9,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_9.wav');
% [thumb10_10,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_10.wav');
% [thumb10_11,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_11.wav');
% [thumb10_12,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_12.wav');
% [thumb10_13,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_13.wav');
% [thumb10_14,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_14.wav');
% [thumb10_15,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_15.wav');
% [thumb10_16,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_16.wav');
% [thumb10_17,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_17.wav');
% [thumb10_18,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_18.wav');
% [thumb10_19,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_19.wav');
% [thumb10_20,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_20.wav');
% [thumb10_21,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_21.wav');
% [thumb10_22,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_22.wav');
% [thumb10_23,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_23.wav');
% [thumb10_24,fs,nbits] = wavread('./At Forearm/Thumb10/Thumb10_24.wav');
% 
% thumb10_1 = transpose(thumb10_1);
% thumb10_2 = transpose(thumb10_2);
% thumb10_3 = transpose(thumb10_3);
% thumb10_4 = transpose(thumb10_4);
% thumb10_5 = transpose(thumb10_5);
% thumb10_6 = transpose(thumb10_6);
% thumb10_7 = transpose(thumb10_7);
% thumb10_8 = transpose(thumb10_8);
% thumb10_9 = transpose(thumb10_9);
% thumb10_10 = transpose(thumb10_10);
% thumb10_11 = transpose(thumb10_11);
% thumb10_12 = transpose(thumb10_12);
% thumb10_13 = transpose(thumb10_13);
% thumb10_14 = transpose(thumb10_14);
% thumb10_15 = transpose(thumb10_15);
% thumb10_16 = transpose(thumb10_16);
% thumb10_17 = transpose(thumb10_17);
% thumb10_18 = transpose(thumb10_18);
% thumb10_19 = transpose(thumb10_19);
% thumb10_20 = transpose(thumb10_20);
% thumb10_21 = transpose(thumb10_21);
% thumb10_22 = transpose(thumb10_22);
% thumb10_23 = transpose(thumb10_23);
% thumb10_24 = transpose(thumb10_24);
% 
% trainingData = [thumb10_5;thumb10_3;thumb10_7;thumb10_1;thumb10_9;thumb10_11;
%                 thumb10_2;thumb10_8;thumb10_4;thumb10_6;thumb10_10;thumb10_12];
% testData = [thumb10_24];
% 
% %Define the groups for the data
% group=[1;1;1;1;1;1;
%        2;2;2;2;2;2];

% [thumb11_1,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_1.wav');
% [thumb11_2,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_2.wav');
% [thumb11_3,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_3.wav');
% [thumb11_4,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_4.wav');
% [thumb11_5,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_5.wav');
% [thumb11_6,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_6.wav');
% [thumb11_7,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_7.wav');
% [thumb11_8,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_8.wav');
% [thumb11_9,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_9.wav');
% [thumb11_10,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_10.wav');
% [thumb11_11,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_11.wav');
% [thumb11_12,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_12.wav');
% [thumb11_13,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_13.wav');
% [thumb11_14,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_14.wav');
% [thumb11_15,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_15.wav');
% [thumb11_16,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_16.wav');
% [thumb11_17,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_17.wav');
% [thumb11_18,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_18.wav');
% [thumb11_19,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_19.wav');
% [thumb11_20,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_20.wav');
% [thumb11_21,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_21.wav');
% [thumb11_22,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_22.wav');
% [thumb11_23,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_23.wav');
% [thumb11_24,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_24.wav');
% [thumb11_25,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_25.wav');
% [thumb11_26,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_26.wav');
% [thumb11_27,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_27.wav');
% [thumb11_28,fs,nbits] = wavread('./At Forearm/Thumb11/Thumb11_28.wav');
% 
% thumb11_1 = transpose(thumb11_1);
% thumb11_2 = transpose(thumb11_2);
% thumb11_3 = transpose(thumb11_3);
% thumb11_4 = transpose(thumb11_4);
% thumb11_5 = transpose(thumb11_5);
% thumb11_6 = transpose(thumb11_6);
% thumb11_7 = transpose(thumb11_7);
% thumb11_8 = transpose(thumb11_8);
% thumb11_9 = transpose(thumb11_9);
% thumb11_10 = transpose(thumb11_10);
% thumb11_11 = transpose(thumb11_11);
% thumb11_12 = transpose(thumb11_12);
% thumb11_13 = transpose(thumb11_13);
% thumb11_14 = transpose(thumb11_14);
% thumb11_15 = transpose(thumb11_15);
% thumb11_16 = transpose(thumb11_16);
% thumb11_17 = transpose(thumb11_17);
% thumb11_18 = transpose(thumb11_18);
% thumb11_19 = transpose(thumb11_19);
% thumb11_20 = transpose(thumb11_20);
% thumb11_21 = transpose(thumb11_21);
% thumb11_22 = transpose(thumb11_22);
% thumb11_23 = transpose(thumb11_23);
% thumb11_24 = transpose(thumb11_24);
% thumb11_25 = transpose(thumb11_25);
% thumb11_26 = transpose(thumb11_26);
% thumb11_27 = transpose(thumb11_27);
% thumb11_28 = transpose(thumb11_28);
% 
% trainingData = [thumb11_5;thumb11_3;thumb11_7;thumb11_13;thumb11_9;thumb11_11;
%                 thumb11_2;thumb11_8;thumb11_4;thumb11_6;thumb11_10;thumb11_12];
% testData = [thumb11_28];
% 
% %Define the groups for the data
% group=[1;1;1;1;1;1;
%        2;2;2;2;2;2];

sampleFolder='Thumb12\';
[thumb12_1,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_1.wav'));
[thumb12_2,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_2.wav'));
[thumb12_3,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_3.wav'));
[thumb12_4,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_4.wav'));
[thumb12_5,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_5.wav'));
[thumb12_6,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_6.wav'));
[thumb12_7,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_7.wav'));
[thumb12_8,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_8.wav'));
[thumb12_9,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_9.wav'));
[thumb12_10,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_10.wav'));
[thumb12_11,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_11.wav'));
[thumb12_12,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_12.wav'));
[thumb12_13,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_13.wav'));
[thumb12_14,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_14.wav'));
[thumb12_15,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_15.wav'));
[thumb12_16,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_16.wav'));
[thumb12_17,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_17.wav'));
[thumb12_18,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_18.wav'));
[thumb12_19,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_19.wav'));
[thumb12_20,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_20.wav'));
[thumb12_21,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_21.wav'));
[thumb12_22,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_22.wav'));
[thumb12_23,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_23.wav'));
[thumb12_24,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_24.wav'));
[thumb12_25,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_25.wav'));
[thumb12_26,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_26.wav'));
[thumb12_27,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_27.wav'));
[thumb12_28,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_28.wav'));
[thumb12_29,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_29.wav'));
[thumb12_30,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_30.wav'));
[thumb12_31,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_31.wav'));
[thumb12_32,fs,nbits] = wavread(strcat(rootPath,sampleFolder,'Thumb12_32.wav'));

thumb12_1 = transpose(thumb12_1);
thumb12_2 = transpose(thumb12_2);
thumb12_3 = transpose(thumb12_3);
thumb12_4 = transpose(thumb12_4);
thumb12_5 = transpose(thumb12_5);
thumb12_6 = transpose(thumb12_6);
thumb12_7 = transpose(thumb12_7);
thumb12_8 = transpose(thumb12_8);
thumb12_9 = transpose(thumb12_9);
thumb12_10 = transpose(thumb12_10);
thumb12_11 = transpose(thumb12_11);
thumb12_12 = transpose(thumb12_12);
thumb12_13 = transpose(thumb12_13);
thumb12_14 = transpose(thumb12_14);
thumb12_15 = transpose(thumb12_15);
thumb12_16 = transpose(thumb12_16);
thumb12_17 = transpose(thumb12_17);
thumb12_18 = transpose(thumb12_18);
thumb12_19 = transpose(thumb12_19);
thumb12_20 = transpose(thumb12_20);
thumb12_21 = transpose(thumb12_21);
thumb12_22 = transpose(thumb12_22);
thumb12_23 = transpose(thumb12_23);
thumb12_24 = transpose(thumb12_24);
thumb12_25 = transpose(thumb12_25);
thumb12_26 = transpose(thumb12_26);
thumb12_27 = transpose(thumb12_27);
thumb12_28 = transpose(thumb12_28);
thumb12_29 = transpose(thumb12_29);
thumb12_30 = transpose(thumb12_30);
thumb12_31 = transpose(thumb12_31);
thumb12_32 = transpose(thumb12_32);

trainingData = [thumb12_5;thumb12_3;thumb12_7;thumb12_1;thumb12_9;thumb12_11;
                thumb12_2;thumb12_8;thumb12_4;thumb12_6;thumb12_10;thumb12_12];
testData = [thumb12_17];

%Define the groups for the data
group=[1;1;1;1;1;1;
       2;2;2;2;2;2];