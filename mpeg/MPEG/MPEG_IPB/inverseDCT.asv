function m = inverseDCT(JQ,array)


T = dctmtx(8);

v=(version('-date')); 
warning off;
if (str2num(v(end-4:end))<2010)
    B2 = blkproc(JQ,[8 8],'x .* P1',array);
    m =  blkproc(B2,[8 8],'P1 * x * P2',T',T);
else
    fun = @(block_struct) round(block_struct.data.*array);
    B2 = blockproc(JQ,[8 8],fun);
    fun = @(block_struct) T'*block_struct.data*T;
    m =  blockproc(B2,[8 8],fun);
end
warning on;


m=m+128;
