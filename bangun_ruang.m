clear all;

clc;

disp('========================================');

disp('>> Program Menghitung Luas dan Volume <<');

disp('========================================');

disp('Masukkan Pilihan Bangun Ruang');

disp('1. Balok');

disp('2. Tabung');

disp('3. Kerucut');

p=input('Pilihan Anda = ');

switch p

case 1

disp('Menghitung Luas dan Volume Balok...');

disp('———————————————————————');

p = input('Panjang =  ');

l = input('Lebar = ');

t = input ('Tinggi = ');

v = p.*l.*t;

x = 2*p*t+2*p*l+2*l*t;

disp(['Volume Balok = ',num2str(v)]);

disp(['Luas Permukaan Balok = ',num2str(x)]);

disp('———————————————————————');

case 2

disp('Menghitung Luas dan Volume Tabung...');

disp('———————————————————————');

r = input('Jari-Jari =  ');

t = input ('Tinggi = ');

v = pi.*r^2.*t;

x = 2*pi*r*t;

disp(['Volume Tabung = ',num2str(v)]);

disp(['Luas Tabung = ',num2str(x)]);

disp('———————————————————————');

case 3

disp('Menghitung Luas dan Volume Kerucut...');

disp('———————————————————————');

r = input('Jari-Jari = ');

t = input ('Tinggi = ');

p = input('Apotema = ');

v = (pi.*r^2.*t)./3;

x = pi*r*(r+p);

disp(['Volume Kerucut = ',num2str(v)]);

disp(['Luas Kerucut = ',num2str(x)]);

disp('———————————————————————');

otherwise

disp('Maaf, Anda Hanya Bisa Memilih 1 - 3!')

end