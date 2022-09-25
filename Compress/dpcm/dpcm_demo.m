
close all
clear
% signal sampling
fs=1/2000;
tn=0:fs:1/25;
%SELECT A SIGNAL ****************************
s=.5*sin(2*pi*50*tn);
%[s,fs]=wavread('bye441');  %read .wav file

%lpc and encoder-decoder parameters
lpclen=20;
bitsize=input('bitsize=');
fprintf('\nPlease wait... data length is %i\n',length(s))
%LPF parameters
tap=100;
cf=.15;

% DPCM with predictor
[Q,b, ai] = dpcm_enco_lpc(s, lpclen, bitsize);
[st]=dpcm_deco_lpc(b, ai, bitsize);
Sa=LPF(tap,cf,st);
%[xa,ya]=stairs(tn,Sa);

figure
subplot(3,1,1):plot(s,'r');
ylabel('amplitude');
title('DPCM with predictor (red:input, green:decoder output, blue: LPF output)');
subplot(3,1,2):plot(st,'g');
ylabel('amplitude');
subplot(3,1,3):plot(Sa,'b');
ylabel('amplitude');
xlabel('index, n');
grid

%fprintf('\npress a key to hear input\n\n');
%pause
%sound(s,fs);
%fprintf('press a key to hear LPF output\n\n');
%pause
%sound(Sa,fs);
