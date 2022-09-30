function [luas,volume] = tabung (t,r)
%----------------------------------------------------
%fungsi : untuk menghitung luas dan volume pada balok
%cara menggunakan :
%[luas,volume] = tabung (5,7)
%----------------------------------------------------
luas = 2*pi*r*t;
volume = pi.*r^2.*t;