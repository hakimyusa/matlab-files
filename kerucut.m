function [luas,volume] = kerucut (r,t,p)
% ---------------------------------------------------
%fungsi : untuk menghitung luas dan volume pada balok
%cara menggunakan :
%[luas,volume] = kerucut (10,12,5)
%----------------------------------------------------
luas = pi*r*(r+p);
volume = (pi.*r^2.*t)./3;