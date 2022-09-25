function [t,x,xx]=sinadm(P,xmean,dmin,dmax) 
 

if nargin < 1 
   disp('Usage: sinadm(P,xmean,dmin,dmax)'); 
   disp('P: Adaptation Parameter, 1<=P<=3'); 
   disp('xmean: mean value of x'); 
   disp('dmin, dmax: min and max of stepsize'); 
   return; 
end; 
 

% given a sampling frequency. 

fs=33; 

 
% construct a quantized sinusoid wave signal using 8-bit quantizer 
% { ranged at (0,255) } for sampling time interval t=(0,1). 

t=[0:1/fs:1]; 

L=length(t); 

f=2; 
x=(sin(2*pi*f*t)+1.0)/2*255; 
x=round(x); 

 

% Adaptive Delta Modulation 

%P=1.8; 
%dmin=2; 
%dmax=40; 

%xmean=128; 

Q=1.0/P; 

 
% given the initial condition. 
d(1)=x(1); 

c(1) =0; 

dd(1)=(dmin+dmax)/2; 

xx(1)=xmean+dd(1); 
 
% calculate the adaptive delta modulation. 
for i = 2:L, 
 d(i)=x(i)-xx(i-1); 

  if d(i) > 0 
   c(i) = 0;  
  else 
   c(i) = 1; 
  end 
  if c(i) == c(i-1) 
   M=P; 
  else 
   M=Q; 
  end 
 dd(i)=M*dd(i-1); 
 %dd(i)=round(dd(i)); 
  if dd(i) < dmin 
   dd(i)=dmin; 

  elseif dd(i) > dmax 
   dd(i)=dmax;
   
   end 
  if c(i) == 0 
   xx(i)=xx(i-1)+dd(i); 
  elseif c(i) == 1 
     xx(i)=xx(i-1)-dd(i); 

  end 
end 

 
% graph of the fixed stepsize delta modulation of a sinusoid wave 
signal. 
figure; 

t1=[0:1/(100*fs):1]; 

x1=(sin(2*pi*f*t1)+1.0)/2*255; 
plot(t1,x1,'-',t,x,'*',t,xx,'x',t(2:L),xx(1:(L-1)),'o'); 
title('Illustration of the adaptive delta modulation'); 
legend('original signal', 'original sample', ... 
   'reconstructed value','predicted value');