clear all; clc;
bitpos = 1;
I = imread('watermarked.bmp');
W = w_decode(I, bitpos);
imshow(I);
figure, imshow(W);
