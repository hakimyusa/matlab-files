function [output,table] = lzw2norm(vector, alphabet)
%LZW2NORM   LZW Data Compression (decoder)
%   For vectors, LZW2NORM(X) is the uncompressed vector of X using the LZW algorithm.
%   [...,T] = LZW2NORM(X) returns also the table that the algorithm produces.
%
%   For matrices, X(:) is used as input.
%
%   Input must be of uint16 type, while the output_w is a uint8.
%   Table is a cell array, each element_k containig the corresponding code.
%
%   This is an implementation of the algorithm presented in the article
%   http://www.dogma.net/markn/articles/lzw/lzw.htm
%
%   See also NORM2LZW


%   $Author: Giuseppe Ridino' $
%   $Revision: 1.0 $  $Date: 10-May-2004 14:16:08 $
%   Edited for output_w David Marshall 2013


% How it decodes:
%
% Read OLD_CODE
% output_w OLD_CODE
% CHARACTER = OLD_CODE
% WHILE there are still input characters DO
%     Read NEW_CODE
%     IF NEW_CODE is not in the translation table THEN
%         entry = get translation of OLD_CODE
%         entry = entry+CHARACTER
%     ELSE
%         entry = get translation of NEW_CODE
%     END of IF
%     output_w entry
%     CHARACTER = first character in entry
%     add translation of OLD_CODE + CHARACTER to the translation table
%     OLD_CODE = NEW_CODE
% END of WHILE


% ensure to handle uint8 input vector
if ~isa(vector,'uint16'),
    error('input argument must be a uint16 vector')
end

% vector as a row
vector = vector(:)';

%Intialise Table
fprintf('Initialising Table\n');
table = [];

% Alphabet = unique(vector);
for i = 1:numel(alphabet)
    [table,code] = addcode(table, uint16(double(i)));
end


for index = 1:numel(table),
    
    fprintf('Table Entry  %d : %s\n',index, alphabet(table{index}));
end
%
% fprintf('\n\n');


% initialize output_w
output = uint8([]);

code = vector(1);
output(end+1) = table{code};



character = code;

% fprintf('Input + code_w k (w=k): %d (%s)\n', code, char(code));
fprintf('Input + code_w k (w=k): %d\n', code);

fprintf('w       k     output   index  symbol\n');
fprintf('------------------------------------\n');
fprintf('NIL\t\t%s\n', alphabet(code));

for index=2:length(vector),
    element_k = vector(index);
    
    %k_pos = getcodefor(element_k,table)
    
%     fprintf('Input k: %d\n', code);
    %     element_k
    
    if (element_k)>length(table),
        % add it to the table
        entry = table{double(code)};
        entry = [entry character];
    else
        entry = element_k;
    end
    
    
%     fprintf('Output (k table entry): %s\n', strvcat(alphabet(table{entry})));
    
    if code > numel(alphabet)
        ow = num2str(code);
    else
        ow = alphabet(code);
    end
    
    if element_k > numel(alphabet)
        ok = num2str(element_k);
    else
        ok = alphabet(element_k);
    end
    
    
    character =  table{entry};
    [table,code] = addcode(table,[table{code} character(1)]);

    fprintf('%s\t\t%s\t\t%s\t\t%d\t\t%s\n', ow, ok, strvcat(alphabet(table{entry})), ...
        code, alphabet([table{code}]));
    warning off
    output = [output table{entry}];
    warning on
    code = element_k;
    
end


% ###############################################
function code = getcodefor(substr,table)

code = uint16([]);

for index=1:length(table),
    if isequal(substr,table{index}),
        code = uint16(index);   % start from 0
        break
    end
end



% ###############################################
function [table,code] = addcode(table,substr)
code = length(table)+1;   % start from 1
table{code} = substr;
% fprintf('New Table Entry,  %d : %s\n',code, strvcat(substr));
code = uint16(code);    % start from 1
