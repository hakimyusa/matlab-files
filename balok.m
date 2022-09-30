function [luas,volume] = balok (p,l,t)
% ---------------------------------------------------
%fungsi : untuk menghitung luas dan volume pada balok
%cara menggunakan :
%[luas,volume] = balok (12,10,5)
%----------------------------------------------------
luas = 2*p*t+2*p*l+2*l*t;
volume = p.*l.*t;