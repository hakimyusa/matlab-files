A = double(imread('cameraman.tif'));
[r c] = size(A);
for x = 1 : r
for y = 1 : c
B(x,y) = A(x,y) .* 2;
end
end
B = clipping(B);
figure, imshow(uint8(B));