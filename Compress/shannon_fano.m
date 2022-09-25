function codes = shannon_fano(P)

% if nargin == 0
%     P = [15 7 6 6 5];
% % P = [0.25 0.25 0.5];
% end

if numel(P) == 1
    codes = {''};
    return;
end

codes = cell(numel(P), 1);

[p, idxp] = sort(P, 2, 'descend');

diff = zeros(numel(p)-1, 1);
for i = 1:numel(p)-1
    diff(i) = abs(sum(p(1:i)) - sum(p(i+1:end)));
end
[~, pivot] = min(diff);

L = p(1:pivot);
R = p(pivot+1:end);

codesL = shannon_fano(L);
codesR = shannon_fano(R);

for i = 1:pivot
    codes{i} = ['0' codesL{i}];
end
for i = pivot+1:numel(p)
    codes{i} = ['1' codesR{i-pivot}];
end

C = cell(size(codes));
for i = 1:numel(idxp)
    C(idxp(i)) = codes(i);
end
codes = C;
