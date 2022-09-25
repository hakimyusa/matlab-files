function JQ=forwardDCT(Im,array)
Im=Im-128;
T = dctmtx(8);
y = blkproc(Im,[8 8],'P1*x*P2',T,T');
JQ = blkproc(y,[8 8],'round(x ./ P1)',array);





% for i=1:8:256
%     for j=1:8:256
%         Jdct(i:i+7,j:j+7)= (T * Im(i:i+7,j:j+7)) * transpose(T);
%     end
% end
% 
% 
% for i=1:8:256
%     for j=1:8:256
%         JQ(i:i+7,j:j+7)= floor(Jdct(i:i+7,j:j+7)./array)+0.5;
%     end
% end


