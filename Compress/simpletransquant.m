im = rgb2gray(imread('lenna.png'));
[h w] = size(im);
Q = 16;
X = im(:);
len = numel(X);

lenh = len_huffman(X);
lena = len_arith(X);
fprintf('Naively:\n');
fprintf('Original: %d,\n Huffman: %d (Ratio: %f),\n Arithmetic: %d (Ratio: %f)\n', ...
    len*8, lenh, lenh/(len*8), lena, lena/(len*8));

% Do simple differencing transform
X0 = double(im(1:2:end, 1:2:end));
X1 = double(im(2:2:end, 1:2:end)) - X0;
X2 = double(im(1:2:end, 2:2:end)) - X0;
X3 = double(im(2:2:end, 2:2:end)) - X0;

% Quantise
X1 = round(X1 ./ Q);
X2 = round(X2 ./ Q);
X3 = round(X3 ./ Q);


X = X0(:);
D = [X1(:); X2(:); X3(:)];

lenhX = len_huffman(X);
lenhD = len_huffman(D);
lenh = lenhX + lenhD;

lenaX = len_arith(X);
lenaD = len_arith(D);
lena = lenaX + lenaD;

fprintf('\n\nAfter transform:\n');
fprintf('Original: %d,\n Huffman: %d (Ratio: %f),\n Arithmetic: %d (Ratio: %f)\n', ...
    len*8, lenh, lenh/(len*8), lena, lena/(len*8));

% Reconstruct image
imrec = zeros(size(im));
imrec(1:2:end, 1:2:end) = X0;
imrec(2:2:end, 1:2:end) = X0 + X1*Q;
imrec(1:2:end, 2:2:end) = X0 + X2*Q;
imrec(2:2:end, 2:2:end) = X0 + X3*Q;

im = double(im);
out = [im imrec];
diff = abs(im - imrec);
figure(1); clf; sc(out);
figure(2); clf; sc(diff);
