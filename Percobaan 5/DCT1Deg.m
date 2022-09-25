close all
%clear all
i = 1:8 % dimensi vektor
f(i) = 80% pengaturan fungsi
figure(1) % plot f
stem(f);
% perhitungan DCT
D = dct(f);
figure(2) % plot D
stem(D);
% membangkitkan fungsi basis
bases = dctmtx(8);
for j = 1 : 8
figure
stem(bases(j,:));
end
% Mengkonstruksi DCT dari fungsi basis

D1 = bases*f';
figure % plot D1
stem(D1);