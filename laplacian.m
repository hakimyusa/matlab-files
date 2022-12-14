function J = laplacian(I, Thres)
Mask = [0 1 0;
        1 -4 1;
        0 1 0];
Tepi = convolve(I, Mask);
J = thresholding(Tepi, Thres);
 
function B = convolve(A, k)
    [r c] = size(A);
    [m n] = size(k);
    h = rot90(k, 2);
    center = floor((size(h)+1)/2);
    left = center(2) - 1;
    right = n - center(2);
    top = center(1) - 1;
    bottom = m - center(1);
    Rep = zeros(r + top + bottom, c + left + right);
    for x = 1 + top : r + top
        for y = 1 + left : c + left
            Rep(x,y) = A(x - top, y - left);
        end
    end
    B = zeros(r , c);
    for x = 1 : r
        for y = 1 : c
            for i = 1 : m
                for j = 1 : n
                    q = x - 1;
                    w = y -1;
                    B(x, y) = B(x, y) + (Rep(i + q, j + w) * h(i, j));
                end
            end
        end
    end
    
function Hasil = thresholding(Array, T)
    row = size(Array, 1);
    col = size(Array, 2);
    Hasil = zeros(row, col);
    for x = 1 : row
        for y = 1 : col
            if Array(x, y) >= T
                Hasil(x, y) = 1;
            else
                Hasil(x, y) = 0;
            end
        end
    end
