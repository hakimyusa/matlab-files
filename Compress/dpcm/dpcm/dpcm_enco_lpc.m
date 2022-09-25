function [Q,b,ai] = dpcm_enco_lpc(s, lpclen, bitsize)
%function [Q,b, ai] = dpcm_enco_lpc(s, lpclen, bitsize)
% s : input signal
% bitsize : encoder bit size
% Q : qunatizer output
% b : encoder output
% e = s(i+1) - s(i)

%s = 2^(-1)*s/max(abs(s));
slen = length(s);
e(1) = s(1);
[Q(1),b(1,:)] = pcm_quan_enco(e(1), bitsize);
st(1) = Q(1);

for i=2:slen  
   if i<=lpclen
      e(i) = s(i)-st(i-1);
      [Q(i),b(i,:)] = pcm_quan_enco(e(i), bitsize);
      st(i) = st(i-1) + Q(i); 
   else
      m=0;
      [a,G]=lpc(s(i-lpclen:i-1),lpclen);
      a = a*G;
      m = 1:lpclen;      
      j=2:lpclen + 1;      
      sth = sum(a(j).*st(i-m));       
      ai(i,:)=a;         
      e(i) = s(i)-sth;      
      [Q(i),b(i,:)] = pcm_quan_enco(e(i), bitsize);
      st(i) = sth + Q(i);          
   end      
end
b=b';
b=b(:)';

   