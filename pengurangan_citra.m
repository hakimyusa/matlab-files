A = double(imread('cameraman.tif'));
B = double(imread('rice.png'));
[r1 c1] = size(A);
[r2 c2] = size(B);
if (r1 == r2) && (c1 == c2)
for x = 1 : r1
for y = 1 : c1
C(x,y) = A(x,y) - B(x,y);
end
end
end
figure, imshow(c);