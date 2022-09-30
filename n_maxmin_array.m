clc;  
 clear all;  

 jumlah = input('Masukkan Bilangan Ke-n: ');
Vektor = [];

for i=1:jumlah
n = input('Masukkan Angka: ');
Vektor = [Vektor n];
end

maksimal = max(Vektor);
minimal = min(Vektor);

disp(['max= ' num2str(maksimal)]);
disp(['min= ' num2str(minimal)]);