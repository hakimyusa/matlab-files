j = 0;
x = input('Masukkan Nilai dalam Bentuk Array []: ');
panjang = length(x);

for i=1:panjang
    
    sisa = mod (x(i),4);
    
    if(sisa == 0)
        j = j+1;
        y(j)=x(i);
    end
end
disp(y(1:j));
        