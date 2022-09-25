function [valq,runq]= huffDecode1(X,MatAC)


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
    k=strmatch(basecode,MatAC,'exact');
    if (isempty(k))
        i=i+1;
    else
        [runt,category]=detableAC2(basecode);
        if category==0 & runt==15
            valq(j)=0;
            runq(j)=15;
            j=j+1;
            i=i+category+1;
            p=i;
        elseif category==0 & runt==0
            valq(j)=0;
            runq(j)=0;
            j=j+1;
            i=i+category+1;
            p=i;
        
        else
            valt = X(i+1:i+category);
            valt = bin2dec(valt);
            valt = chkcategory(valt,category);
            runq(j) = runt;
            valq(j) = valt;
            j=j+1;
            i=i+category+1;
            p=i;
        end
    end    
end
