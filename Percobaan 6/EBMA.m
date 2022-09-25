
function [vm,hm,pframe]=EBMA(refframe, newframe, bsize, Vrange, Hrange)


Ny=size(refframe,1); Nx=size(refframe,2);

%%%%The number of blocks along y and x
bdy=ceil(Ny/bsize); bdx=ceil(Nx/bsize);

%%%%The arrays of the motion vectors 
vm=zeros(bdy,bdx); hm=zeros(bdy,bdx);


%%%In this matrix, the mean absolute errors will be hold
err=zeros(2*Vrange+1, 2*Hrange+1);


MAX_ERROR=255^2*bsize^2;


br=0;
for r=1:bsize:Ny-(bsize-1) %%%The left of the current block
    br=br+1; 
    bc=0; 
    for c=1:bsize:Nx-(bsize-1)  %%%The top of the current block
        bc=bc+1; 
        %% (br,bc) expresses the coordinates of the current block 
        

        bbr=0;
        for v=-Vrange:Vrange  %%The displacement of the block along vertical direction in the target frame
            bbr=bbr+1;
            bbc=0;
            for h=-Hrange:Hrange %%The displacement of the block along horizontal direction in the target frame
                bbc=bbc+1;
                if ((r+v<1) | (r+v>Ny-(bsize-1)) | (c+h<1) | (c+h>Nx-(bsize-1)))
                    err(bbr, bbc)=MAX_ERROR;
                else
                    x=newframe(r:r+(bsize-1), c:c+(bsize-1))- ...
                      refframe(r+v:r+v+(bsize-1), c+h:c+h+(bsize-1));
                err(bbr, bbc)=sum(sum(abs(x))); 
             end
            end     %the motion search window    
        end

        [y, i]=min(err);
        [errmin,j]=min(y);
        v=i(j)-Vrange-1;
        h=j-Hrange-1;


       
        vm(br,bc)=v;
        hm(br,bc)=h;

       %disp([r,c,br,bc,v,h,v0,h0]);
       pframe(r:r+(bsize-1), c:c+(bsize-1))=refframe(r+v:r+v+(bsize-1), c+h:c+h+(bsize-1));

    end
end

