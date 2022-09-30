x = input('Masukkan Nominal Rupiah Uang = ');
fprintf('\nUSA/Dolar, SGD, JPY\n')
uang = input('Konvert ke kurs = ','s');
error =0;
switch uang
case {'USA','Dolar'}
y = x/13515;
case 'SGD'
y = x/9966.82;
case 'JPY'
y = x/82.68;
otherwise
y = x;
end
fprintf('\nHasil Konversi Rp%g ke %s = %g\n',x,uang,y);