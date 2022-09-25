
function [vm,hm,pframe]=EBMA_half(refframe, newframe, bsize, Vrange, Hrange)

Ny=size(newframe,1); Nx=size(newframe,2);


%%%%The number of blocks along y and x
bdy=ceil(Ny/bsize); bdx=ceil(Nx/bsize);

%%%%The arrays of the motion vectors 
vm=zeros(bdy,bdx); hm=zeros(bdy,bdx);


%%%In this matrix, the mean absolute errors will be hold
err=zeros(4*Vrange+1, 4*Hrange+1);


MAX_ERROR=255^2*bsize^2;


%up sample the reference frame, by filling the half pels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
row=Ny; col=Nx;
row2=row*2; col2=col*2;

refframe2(1:2:row2,1:2:col2)=refframe(1:row,1:col);
refframe2(1:2:row2,2:2:col2-2)=(refframe(1:row,1:col-1)+refframe(1:row,2:col))/2;
refframe(1:2:row2,col2)=refframe(1:row,col);

refframe2(2:2:row2-2,1:2:col2)=(refframe(1:row-1,1:col)+refframe(2:row,1:col))/2;
refframe2(row2,1:2:col2)=refframe(row,1:col);
refframe2(2:2:row2-2,2:2:col2-2)=(refframe(1:row-1,1:col-1)+...
   refframe(1:row-1,2:col)+refframe(2:row,1:col-1)+refframe(2:row,2:col))/4;
refframe2(2:2:row2-2,col2)=(refframe(1:row-1,col)+refframe(2:row,col))/2;
refframe2(row2,2:2:col2-2)=(refframe(row,1:col-1)+refframe(row,2:col))/2;
refframe2(row2,col2)=refframe(row,col);

refframe = refframe2;





R=1:bsize:Ny-(bsize-1);
C=1:bsize:Nx-(bsize-1);
V=-Vrange:0.5:Vrange;
H=-Hrange:0.5:Hrange;

br=0;
for r=R %%%The left of the current block
    br=br+1; 
    bc=0; 
    for c=C  %%%The top of the current block
        bc=bc+1; 
        %% (br,bc) expresses the coordinates of the current block 
        

        bbr=0;
        for v=V  %%The displacement of the block along vertical direction in the target frame
            bbr=bbr+1;
            bbc=0;
            for h=H %%The displacement of the block along horizontal direction in the target frame
                bbc=bbc+1;
                
                start1Y=r;
                end1Y=r+(bsize-1);
                start1X=c;
                end1X=c+(bsize-1);
                
                start2Y = 2*(start1Y+v);
                end2Y = 2*(end1Y+v);
                start2X = 2*(start1X+h);
                end2X = 2*(end1X+h);
  
                if (start2Y<1 || end2Y>2*Ny ||...
                    start2X<1 || end2X>2*Nx)
                        err(bbr, bbc)=MAX_ERROR;
                else
                    a=newframe(start1Y:end1Y,start1X:end1X);
                    b=refframe(start2Y:2:end2Y,start2X:2:end2X);
                    x=a-b;
                      
                    err(bbr, bbc)=sum(sum(abs(x))); 
                end
            end     %the motion search window    
        end

        f=find(err==min(min(err)));
        f=f(1);
        [i,j] = ind2sub(size(err),f);
        
        v=V(i);
        h=H(j);


       
        vm(br,bc)=v;
        hm(br,bc)=h;

       
        start1Y=r;
        end1Y=r+(bsize-1);
        start1X=c;
        end1X=c+(bsize-1);

        start2Y = 2*(start1Y+v);
        end2Y = 2*(end1Y+v);
        start2X = 2*(start1X+h);
        end2X = 2*(end1X+h);
        
               
        b=refframe(start2Y:2:end2Y,start2X:2:end2X);
       
        pframe(start1Y:end1Y,start1X:end1X) = b;
          

    end
end

