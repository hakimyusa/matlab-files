clc, close all , clear all


% v1=[]; %tested
% v1=[1] %tested
% v1=[1 5 7 1 10] %tested

v1=rand(1,7)

vo=diffencodevec(v1); %%Differential Encoding
v2=diffdecodevec(vo)  %%Differential Decoding


% % v1 is equal to v2, igonoring round-off error

