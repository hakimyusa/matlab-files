function []=quant_mulaw(inname,outname, N, mu);
%Membaca sinyal input
[x,fs]=audioread(inname);
xmin=min(x); xmax=max(x);
magmax=max(abs(x));
xmin=-magmax; xmax=magmax;
Q=(xmax-xmin)/N;
disp('xmin,xmax,N,Q,mu');
disp([xmin,xmax,N,Q,mu]);
%Terapkan transform mu-law pada sampel original
y=xmax*log10(1+abs(x)*(mu/xmax))/log10(1+mu);
%Terapkan kuantisasi seragam pada nilai absolute setiap sampel
yq=floor((y-xmin)/Q)*Q+Q/2+xmin;
%Terapkan invers transform mu-law pada sekuen terkuantisasi
xq=(xmax/mu)*(10.^((log10(1+mu)/xmax)*yq)-1).*sign(x);
%Bandingkan kualitas sound
audiowrite(outname,xq,fs);
sound(x,fs);
fprintf('\n Hit a key to continue');
pause;
sound(xq,fs);
%Plot bentuk gelombang pada seluruh perioda
t=1:length(x);
figure; plot(t,x,'r:');
hold on; plot(t,xq,'b-');
axis tight; grid on;
legend('original','quantized')
%Plot bentuk gelombang pada perioda yang dipilih
t=2000:2200;
figure; plot(t,x(2000:2200),'r:');
hold on; plot(t,xq(2000:2200),'b-');
axis tight; grid on;
% Hitung MSE
D=x-xq;
MSE=mean(D.^2);
fprintf('\n Error antara original dan quantized =%g\n\n',MSE)