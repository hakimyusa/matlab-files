% dct2manual.m
close all;
im = im2double(rgb2gray(imread('lenna.png')));
im = imresize(im, 1/16);
[h w] = size(im);
D1 = dctmtx(h);
D2 = zeros(h*h, h*h);
idx = 1;
for i = 1:h
for j = 1:h
outer = D1(:, j) * D1(:, i)';
D2(:, idx) = outer(:);
idx = idx + 1;
end
end
% Manual dct2
F = D2 * im(:);
F = reshape(F, h, h)
% Proper dct2
Fmatlab = dct2(im)

diff = abs(F - Fmatlab);
sum(diff(:))
% Inverse:
frec = D2' * F(:);
frec = reshape(frec, h, h);
diff = abs(frec - im);
sum(diff(:))