function [t,x,xx]=sindm(Q, xmean); 
if nargin < 1 
   disp('Usage: sindm(Q, xmean)'); 
   disp('Q: stepsize'); 
   disp('xmean: mean value of the signal'); 
   return; 
end; 
 
 
% construct a quantized sinusoid wave signal using 8-bit quantizer 

% { ranged at (0,255) } for sampling time interval t=(0,1). 

 

% given a sampling frequency. 
fs=33; 
t=[0:1/fs:1]; 

L=length(t); 

f=2; 

x=(sin(2*pi*f*t)+1.0)/2*255; 
x=round(x); %the round operation essentially quantizes to 8 bits, 
because the range 

         % of x is 0-255. 

 

% Delta Modulation 
D=Q*ones(L); % fixed stepsize=30 
%xmean=128; 
 

% given the initial condition. 

d(1)=x(1); %difference signal 
c(1) =0; %coded signal 
dd(1)=D(1); %quantized difference signal 
xx(1)=xmean+dd(1); %reconstructed signal 
%sindm.m 
% calculate the delta modulation. 
for i = 2:L, 
 d(i)=x(i)-xx(i-1); 

  if d(i) > 0 
   c(i) = 0; 

   dd(i)=D(i); 
  else 
   c(i) = 1; 
   dd(i)=(-1)*D(i); 

  end 
 xx(i)=xx(i-1)+dd(i); 
end 
 

figure; 

t1=[0:1/(100*fs):1]; 

x1=(sin(2*pi*f*t1)+1.0)/2*255; 
plot(t1,x1,t,x,'*',t,xx,'x',t(2:L),xx(1:(L-1)),'o'); 
title('Illustration of the linear delta modulation'); 
legend('original signal', 'original sample', ... 
    'reconstructed value','predicted value'); 
