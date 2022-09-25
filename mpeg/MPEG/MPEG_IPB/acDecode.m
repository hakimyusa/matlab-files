function deLayer = acDecode(B,MatAC)

[valb,runb]=huffDecode1(B,MatAC);  
vs=size(valb);
v=1;
j=0;
for i=1:vs(2)
    j=j+1;
    baseval(v,j)=valb(i);
    baserun(v,j)=runb(i);
    if (valb(i)==0 & runb(i)==0)
        temp=rld(baseval(v,1:j),baserun(v,1:j));
        tempSize=size(temp);
        deLayer(v,1:tempSize(2))=temp;
        v=v+1;
        j=0;
    end
end