F = imread('cameraman.tif');
[r c] = size(F);
for x = 1 : r
for y = 1 : c
G(x,y) = 255 - F(x,y);
end
end
figure, imshow(F);
figure, imshow(G);