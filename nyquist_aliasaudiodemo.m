close all 
clear tt_sf
samples = 22050; %jumlah sample
samp_freq = 22050; %frekuensi sample
nyq = samp_freq/2 %Batas nyquist frekuensi sample samp_time = samples/samp_freq; %waktu sampling
freq = 22050 %frekuensi gelombang sinus t = [0:samples-1]; %jumlah waktu sample
tt = t/10000; %Setiap titik adalah 0.1
mdetik,di plot menjadi 1 detik
size(tt);
sint = sin(tt);
radfreq = freq*(2*pi)/1;
sint2 = sin(radfreq*tt); % Frekuensi radial adalah radfreq, sedangkan Hz adalah radfreq/(2*pi)
plot(sint2(1:100), 'k')
title('radfreq plot')
%play sample sint2
p = audioplayer(sint2, samp_freq);
play(p, [1 samples]);
pause(1)
disp('Doing Sampling:');
if nyq - freq < 0 alias = nyq - abs(nyq-freq), end cnt = 1;
for ii = 1:samp_time:samples tt_sf(cnt) = ii/samples; cnt=cnt+1;
end
if ii < samples tt_sf(cnt) = 1; end sint3 = sin(radfreq*tt_sf);
hold on
tt_sf_sze = size(tt_sf,2)
figure plot(sint3(1:100), 'r')
p = audioplayer(sint3, nyq);
play(p, [1 tt_sf_sze]);
%figure, plot (sint3(1:100), 'r.'), hold on, plot(sint2(1:100), 'k')