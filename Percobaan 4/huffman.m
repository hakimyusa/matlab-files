function CODE = huffman(p)
global CODE
CODE = cell(length(p), 1);
if length(p) > 1
p = p / sum(p);
s = reduce(p);
makecode(s, []);
else
CODE = {'1'};
end;
for i = 1:numel(CODE)
c = CODE{i};
t = c; c(c=='1') = '0'; c(t=='0') = '1';
CODE{i} = c;
end