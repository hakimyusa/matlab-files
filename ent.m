function H = ent(X)

X = X(:);

P = probs(X);

% Calculate entropy in bits
H = -sum(P .* log2(P));



