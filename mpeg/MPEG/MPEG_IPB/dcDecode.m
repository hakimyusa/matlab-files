function deDC = dcDecode(X,MatDC)
valDC= huffDecodeDC(X,MatDC);

valDCSize=length(valDC);

deDC(1)=valDC(1);
for i=2:valDCSize
    deDC(i)=valDC(i)+deDC(i-1);
end