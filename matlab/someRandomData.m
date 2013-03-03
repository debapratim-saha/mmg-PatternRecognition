% This function generates some random data with known patterns in it due to
% the controlled frequency component addition.

function [data,group]=someRandomData()
t= 0:.01:10;
f=[5 10 12 14 15 18 21 22];
A = sin (f(1)*t)+sin (f(3)*t)+sin (f(5)*t)+sin (f(7)*t);
B = sin (f(2)*t)+sin (f(4)*t)+sin (f(6)*t)+sin (f(8)*t);
C = sin (f(1)*t)+sin (f(2)*t)+sin (f(3)*t)+sin (f(4)*t);
D = sin (f(5)*t)+sin (f(6)*t)+sin (f(7)*t)+sin (f(8)*t);

A1= sin (f(1)*0.5*t)+sin (f(3)*0.5*t)+sin (f(5)*0.5*t)+sin (f(7)*0.5*t);
A2= sin (f(1)*0.75*t)+sin (f(3)*0.75*t)+sin (f(5)*0.75*t)+sin (f(7)*0.75*t);
B1= sin (f(2)*0.5*t)+sin (f(4)*0.5*t)+sin (f(6)*0.5*t)+sin (f(8)*0.5*t);
B2= sin (f(2)*0.75*t)+sin (f(4)*0.75*t)+sin (f(6)*0.75*t)+sin (f(8)*0.75*t);

data=[A;A1;A2;B;B1;B2;C;D];

%Define the groups for the data
group=[1;1;1;2;2;2;3;4]; 
