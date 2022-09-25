function lh = len_huffman(X)

X = X(:);
pr = probs(X);
codes = huffman(pr);
len = numel(X);

lh = 0;
for i = 1:numel(codes)
    lh = lh + len * pr(i) * numel(codes{i});
end
