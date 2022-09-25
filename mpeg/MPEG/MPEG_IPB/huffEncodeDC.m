function X=huffEncodeDC(val)
%%%huffman encoding
X=[];
es=size(val);
for i=1:es(2)
    
    if val(i) < 0
        temp=val(i);
        temp=abs(temp);
        len=length(dec2bin(temp));
        temp=bitcmp_old(temp,len);
        temp1=dec2bin(temp,len);
        basecode=tableDC(len);
        X=strcat(X,basecode);
        X=strcat(X,temp1);
    elseif val(i) > 0
        temp=val(i);
        temp=dec2bin(temp);
        len=length(temp);
        basecode=tableDC(len);
        X=strcat(X,basecode);
        X=strcat(X,temp);
    elseif val(i) == 0 
        temp=val(i);
        len=0;
        temp=dec2bin(temp);
        basecode=tableDC(len);
        X=strcat(X,basecode);
        %X=strcat(X,temp);
    end
end
