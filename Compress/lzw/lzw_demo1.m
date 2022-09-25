%LZW DEMO 

% string to compress
str = '^WED^WE^WEE^WEB^WET';

fprintf('Input String: %s\n')
fprintf('\n\n');

% pack it
[packed,table]=norm2lzw(uint8(str));

fprintf('\n\n');
fprintf('Output code is:'), packed

fprintf('\n\n');

input('Output Table (New Elements):');

% print table

[m n] = size(table);

for i = 257:n
    fprintf('%d : %s\n', i-1, char(table{i}));
    
end

fprintf('\n\n');

input('DECODING');




% unpack it
[unpacked,table]=lzw2norm(packed);

% transfor it back to char array
fprintf('\nDecoded Stream is:')
  unpacked = char(unpacked)



% test
isOK = strcmp(str,unpacked)

% show new table elements

fprintf('\n\n');

input('Output Table (New Elements):');
% print table

[m n] = size(table);

for i = 257:n
    fprintf('%d : %s\n', i-1, char(table{i}));
    
end

fprintf('\n\n');