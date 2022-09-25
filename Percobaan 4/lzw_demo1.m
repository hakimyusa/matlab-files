%LZW DEMO 

% string to compress
% str = '^WED^WE^WEE^WEB^WET';
str = 'BANANA_BANDANA';
% str = 'AAAAAAAAAAAAAAAA';

fprintf('String: %s\n')
fprintf('\n\n');

% pack it
[packed,table, alphabet]=norm2lzw(uint8(str));

fprintf('\n\n');
fprintf('Output code is:\n'), packed

fprintf('\n\n');

fprintf('Output Table (New Elements):\n');

% print table

[m n] = size(table);

for i = numel(alphabet)+1:n
    fprintf('%d : %s\n', i, char(table{i}));
    
end

% return;
fprintf('\n\n');

fprintf('DECODING\n');

% unpack it
[unpacked,utable]=lzw2norm(packed, alphabet);

% transfor it back to char array
fprintf('\nDecoded Stream is:')
  unpacked = char(alphabet(unpacked))

% test
isOK = strcmp(str,unpacked)

% show new table elements

fprintf('\n\n');

fprintf('Output Table (New Elements):\n');
% print table

[m n] = size(utable);

for i = numel(alphabet)+1:n
    fprintf('%d : %s\n', i, char(alphabet(utable{i})));
    
end

fprintf('\n\n');
