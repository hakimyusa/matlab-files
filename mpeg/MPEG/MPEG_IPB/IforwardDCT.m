function [JO,JQ]=IforwardDCT(Im,array)
Im=Im-128;
T = dctmtx(8);

v=(version('-date')); 
warning off;
if (str2num(v(end-4:end))<2010)
    JO = blkproc(Im,[8 8],'P1*x*P2',T,T');
    JQ = blkproc(JO,[8 8],'round(x ./ P1)',array);
else
    fun = @(block_struct) T*block_struct.data*T';
    JO = blockproc(Im,[8 8],fun);
    fun = @(block_struct) round(block_struct.data./array);
    JQ = blockproc(JO,[8 8],fun);
end
warning on;


