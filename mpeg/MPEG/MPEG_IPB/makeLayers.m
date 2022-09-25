%%%% X contains the encoding bits for the AC coefficients
%%%% B contains the encoding bits for the DC coefficients
%%%% DC are the DC coefficients
function [X,B,DC]= makeLayers(c)

%tic
B=[];
counter=0;


IRegion = 1:8:size(c,1);
JRegion = 1:8:size(c,2);
DC=zeros(1,numel(IRegion)*numel(JRegion));
for i=IRegion
    for j=JRegion
        counter=counter+1;
        scanzz=ZigZag(c(i:i+7,j:j+7));
        DC(counter)=scanzz(1);
        [val,run]=rle(scanzz(2:64));
	    temp = huffEncode1(val,run);
        B=[B temp];
    end
end



%%%%DPCM on DC coefficients
diffDC = [DC(1) diff(DC)];

X=huffEncodeDC(diffDC);

%disp('makeLayers:');
%toc
