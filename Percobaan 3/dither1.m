im = imread('lena.bmp');
in = imread('lena.bmp')
di = 4*ones(4,4);
[m n] = size(im);
mat = repmat(di, m/4, n/4);
im = im / 17;
dithered = im > mat;

imshow(dithered), title('Hasil dari Dithered');

figure;
imshow(in), title('Original');