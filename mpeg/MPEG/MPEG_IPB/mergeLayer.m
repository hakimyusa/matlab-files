function frame = mergeLayer(DC,BaseLayer)

[NY,NX] = wantedFrameSize();


Blimit=63;
bbZero=[];
bb=size(BaseLayer);
if bb(2) > Blimit
    BL(1:bb(1,1),1:Blimit)=BaseLayer(1:bb(1,1),1:Blimit);
else
    BL=BaseLayer;
    bb=size(BL);
    numZero=abs(Blimit-bb(2));
    bbZero=zeros(1,numZero);
end

bb=size(BL);


%vSize=size(v);
for i=1:bb(1,1)
    bLayer(i,1)=DC(i);
    
    tempBase=BL(i,1:bb(2));
    tempDeBaseLayer=[tempBase bbZero];
    size(tempDeBaseLayer);
    bLayer(i,2:Blimit+1)=tempDeBaseLayer;
    
    
    
    
    Layer(i,1:Blimit+1)=bLayer(i,1:Blimit+1);
    
end

v=0;
for i=1:8:NY %%%%dim           %%%%%My comments, NY
    for j=1:8:NX %%%dim %%%%%My comments, NX
        v=v+1;
        frame(i:i+7,j:j+7)=dezigzag(Layer(v,1:64));
    end
end
