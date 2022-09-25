function valq= huffDecodeDC(X,MatDC)
%huffman decoding

i=1;
j=1;
p=1;
v=1;
aa=[];
xSize=length(X);
while i~=xSize+1
    
    basecode=X(p:i);
    %aa=strcat(aa,basecode);
    k=strmatch(basecode,MatDC,'exact');
    if (isempty(k))
        i=i+1;
    else
        category=detableDC(basecode);

        if category==0 
            valq(j)=0;
            j=j+1;
            i=i+category+1;
            p=i;
        else
            %[runt,category]=detableAC(basecode);
            valt = X(i+1:i+category);
            valt = bin2dec(valt);
            valt = chkcategory(valt,category);
            valq(j) = valt;
            j=j+1;
            i=i+category+1;
            p=i;
        end
    end
    
end
%runq(j)=0;
%valq(j)=0;