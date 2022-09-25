function category=detableDC(basecode)
if strcmp(basecode,'00')==1
    category=0;
elseif strcmp(basecode,'010')==1
    category=1;
elseif strcmp(basecode,'011')==1
    category=2;
elseif strcmp(basecode,'100')==1
    category=3;
elseif strcmp(basecode,'101')==1
    category=4;
elseif strcmp(basecode,'110')==1
    category=5;
elseif strcmp(basecode,'1110')==1
    category=6;
elseif strcmp(basecode,'11110')==1
    category=7;
elseif strcmp(basecode,'111110')==1
    category=8;
elseif strcmp(basecode,'1111110')==1
    category=9;
elseif strcmp(basecode,'11111110')==1
    category=10;
elseif strcmp(basecode,'111111110')==1
    category=11;
end    
