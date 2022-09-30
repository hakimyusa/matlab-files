function W = w_decode(I, bitpos)
Mw = size(I, 1);
Nw = size(I, 2);
for i = 1 : Mw
    for j = 1 : Nw
        W(i, j) = bitget(I(i, j), bitpos);
    end
end
W = 256 * W;
