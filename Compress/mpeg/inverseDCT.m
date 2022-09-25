function m = inverseDCT(JQ,array)

% %m=blkproc(JQ,[8 8],'idct2');
% %%%%%%%%%inverse quantization
% for i=1:8:256
%     for j=1:8:256
%         Jdct(i:i+7,j:j+7)=JQ(i:i+7,j:j+7) .*array;
%     end
% end
% 
% 
% 
% %IDCT
% for i=1:8:256
%     for j=1:8:256
%         m(i:i+7,j:j+7)=round( ( transpose(T)*(Jdct(i:i+7,j:j+7) *T) ))+128;
%     end
% end
% 
% m=uint8(m);

T = dctmtx(8);
B2 = blkproc(JQ,[8 8],'x .* P1',array);
m = blkproc(B2,[8 8],'P1 * x * P2',T',T);
m=m+128;
%m=uint8(m+128);