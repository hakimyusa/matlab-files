freq = [100 1];
total = sum(freq);
probs = freq./total;

len = 1000000;
seq = randsrc(1, len, [1:numel(freq); probs]);
code = arithenco(seq, freq);

sa = numel(code);
ca = sa/len;

sh = -sum(probs .* log2(probs));
fprintf('Shannon''s limit: %f binary digits per sybmol\n\n', sh); 
fprintf('With arithmetic coding:\n');

fprintf('Compressed length: %f, ratio: %f\n\n', sa, ca);


codes = huffman(probs);
lenh = 0;
for i = 1:numel(codes)
    lenh = lenh + len * probs(i) * numel(codes{i});
end

fprintf('With Huffman coding:\n');
fprintf('Compressed length: %f, ratio: %f\n\n', lenh, lenh/len);
