function []=demo_quant(inname,outname, N);
%Membaca sinyal input
[x,fs]=audioread(inname);
xmin=min(x); xmax=max(x);
Q=(xmax-xmin)/N;
disp('xmin,xmax,N,Q');
disp([xmin,xmax,N,Q]);
%Terapkan kuantisasi seragam pada setiap sample
xq=sign(x).*(floor((abs(x)+Q/2)/Q)*Q);
%Bandingkan kualitas suara
audiowrite(outname,xq,fs);
sound(x,fs);
fprintf('\n Hit a key to continue');
pause;
sound(xq,fs);
%Plot bentuk gelombang pada seluruh perioda
t=1:length(x);
figure; plot(t,x,'r:');
hold on;
axis tight; grid on;
legend('original')
%figure; plot(t,x,'r:');
hold on; plot(t,xq,'b-');
axis tight; grid on;
legend('original','quantized')
%Plot bentuk gelombang pada perioda yang dipilih
t=5000:5100;
figure; plot(t,x(5000:5100),'r:');
hold on; plot(t,xq(5000:5100),'b-');
axis tight; grid on;
% Hitung MSE
D=x-xq;
MSE=mean(D.^2);
fprintf('\n Error antara original dan quantized =%g\n\n',MSE)