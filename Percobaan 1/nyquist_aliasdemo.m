close all
clear tt_sf
samples = 10000;
samp_freq = 20
nyq = samp_freq/2
samp_time = samples/samp_freq;
freq = 4
t = [0:samples-1];
tt = t/10000;
size(tt);
sint = sin(tt);
radfreq = freq*(2*pi)/1;
sint2 = sin(radfreq*tt);
plot(tt, sint2, 'k')
title('radfreq plot')
pause(1)

if nyq - freq < 0 alias = nyq - abs(nyq-freq), end
cnt = 1;

for ii = 1:samp_time:samples
tt_sf(cnt) = ii/samples;
cnt=cnt+1;

end

if ii < samples tt_sf(cnt) = samples/10000; end
sint3 = sin(radfreq*tt_sf);

hold on
tt_sf_sze = size(tt_sf,2)
plot(tt_sf, sint3, 'r')
figure, plot(tt_sf, sint3, 'r.'), hold on, plot(tt, sint2)
'k';
