function s = reduce(p);
s = cell(length(p), 1);
for i = 1:length(p)
s{i} = i;
end
while numel(s) > 2
[p, i] = sort(p);
p(2) = p(1) + p(2);
p(1) = [];
s = s(i);
s{2} = {s{1}, s{2}};
s(1) = [];
end