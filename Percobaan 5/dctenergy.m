close all;
RGB = imread('autumn.tif');
I = rgb2gray(RGB);
figure(1); imshow(I);
J = dct2(I);
% Truncate
f = 40;
if 1
JT = zeros(size(J));
JT(1:f, 1:f) = J(1:f, 1:f);
J = JT;
end
figure(2);
J(0 == J) = 1e-10;

E = log(abs(J));
imagesc(E);
figure(3);
imagesc(idct2(J)); colormap gray;