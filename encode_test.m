clear all; clc;
bitpos = 1;
cover = imread('lena.jpg');
message = imread('cameraman.tif');
I = w_encode(cover, message, bitpos);
imwrite(I,'watermarked.bmp');
imshow(cover);
figure, imshow(uint8(I));
