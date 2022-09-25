function la = len_arith(X)

X = X(:);
len = numel(X);
[uX, i, j] = unique(double(X));
la = numel(arithenco(j, probs(X).*len));
