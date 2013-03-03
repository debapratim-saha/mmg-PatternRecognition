function [trainingData,group,testData]=loadMmgData()
%This function loads all the MMG data formatted as follows -
%row    = new sample and
%column = sample data
% [thumb3_1,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_1.wav');
% [thumb3_2,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_2.wav');
% [thumb3_3,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_3.wav');
% [thumb3_4,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_4.wav');
% [thumb3_5,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_5.wav');
% [thumb3_6,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_6.wav');
% [thumb3_7,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_7.wav');
% [thumb3_8,fs,nbits] = wavread('./At Thumb/Thumb3/Thumb3_T_8.wav');

% thumb3_1 = transpose(thumb3_1);
% thumb3_2 = transpose(thumb3_2);
% thumb3_3 = transpose(thumb3_3);
% thumb3_4 = transpose(thumb3_4);
% thumb3_5 = transpose(thumb3_5);
% thumb3_6 = transpose(thumb3_6);
% thumb3_7 = transpose(thumb3_7);
% thumb3_8 = transpose(thumb3_8);
% 
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
% trainingData = [thumb5_1;thumb5_3;thumb5_5;
%                 thumb5_6;thumb5_4];
% testData = [thumb5_2];
% 
% %Define the groups for the data
% group=[1;1;1;2;2];

[thumb6_1,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_1.wav');
[thumb6_2,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_2.wav');
[thumb6_3,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_3.wav');
[thumb6_4,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_4.wav');
[thumb6_5,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_5.wav');
[thumb6_6,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_6.wav');
[thumb6_7,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_7.wav');
[thumb6_8,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_8.wav');
[thumb6_9,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_9.wav');
[thumb6_10,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_10.wav');
[thumb6_11,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_11.wav');
[thumb6_12,fs,nbits] = wavread('./At Forearm/Thumb6/Thumb6_12.wav');

thumb6_1 = transpose(thumb6_1);
thumb6_2 = transpose(thumb6_2);
thumb6_3 = transpose(thumb6_3);
thumb6_4 = transpose(thumb6_4);
thumb6_5 = transpose(thumb6_5);
thumb6_6 = transpose(thumb6_6);
thumb6_7 = transpose(thumb6_7);
thumb6_8 = transpose(thumb6_8);
thumb6_9 = transpose(thumb6_9);
thumb6_10 = transpose(thumb6_10);
thumb6_11 = transpose(thumb6_11);
thumb6_12 = transpose(thumb6_12);

trainingData = [thumb6_5;thumb6_7;thumb6_9;thumb6_1;
                thumb6_4;thumb6_6;thumb6_2;thumb6_10;thumb6_12];
testData = [thumb6_3];

%Define the groups for the data
group=[1;1;1;1;2;2;2;2;2];
