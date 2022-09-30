%Contoh Perulangan for 
%Mencetak dan menjumlahkan angka 1 hingga n. 
clc; 
a=[]; 
m=0; %nilai awal penjumlahan 
n=input('Input nilai n = '); 
 for k = 1:1:n 
      a(k) = k; 
      m=m+k;   end 
disp(['Deret   = ',num2str(a)]) 
disp(['Jumlah  = ',num2str(m)]) 