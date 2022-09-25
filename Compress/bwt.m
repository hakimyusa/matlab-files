function [result, index, permutation] = bwt(seq)

seq = seq(:);
L = numel(seq);
R = zeros(L);
for i = 1:L
    R(:, i) = seq([i:end 1:i-1]);
end
permutation = [L 1:L-1];

[sR, index] = sortrows(R);
permutation = permutation(index);
index = find(index == 1, 1);
result = cast(sR(:, end)', class(seq));
