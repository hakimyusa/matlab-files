% Computes motion vectors using exhaustive search method
%
% Input
%   imgP : The image for which we want to find motion vectors
%   imgI : The reference image
%   mbSize : Size of the macroblock
%   p : Search parameter  (read literature to find what this means)
%
% Output
%   motionVect : the motion vectors for each integral macroblock in imgP


function motionVect = motionEstES(imgP, imgI, mbSize, p)

% 
% 
% [row col] = size(imgI);
% 
% vectors = zeros(2,row*col/mbSize^2);
% costs = ones(2*p + 1, 2*p +1) * 65537;
% 
% %computations = 0;
% 
% % we start off from the top left of the image
% % we will walk in steps of mbSize
% % for every marcoblock that we look at we will look for
% % a close match p pixels on the left, right, top and bottom of it
% 
% mbCount = 1;
% for i = 1 : mbSize : row-mbSize+1
%     for j = 1 : mbSize : col-mbSize+1
%         
%         % the exhaustive search starts here
%         % we will evaluate cost for  (2p + 1) blocks vertically
%         % and (2p + 1) blocks horizontaly
%         % m is row(vertical) index
%         % n is col(horizontal) index
%         % this means we are scanning in raster order
%         
%         for m = -p : p        
%             for n = -p : p
%                 refBlkVer = i + m;   % row/Vert co-ordinate for ref block
%                 refBlkHor = j + n;   % col/Horizontal co-ordinate
%                 if ( refBlkVer < 1 || refBlkVer+mbSize-1 > row ...
%                         || refBlkHor < 1 || refBlkHor+mbSize-1 > col)
%                     continue;
%                 end
%                 costs(m+p+1,n+p+1) = costFuncMAD(imgP(i:i+mbSize-1,j:j+mbSize-1), ...
%                      imgI(refBlkVer:refBlkVer+mbSize-1, refBlkHor:refBlkHor+mbSize-1));
% %                computations = computations + 1;
%                 
%             end
%         end
%  %       costs
%         % Now we find the vector where the cost is minimum
%         % and store it ... this is what will be passed back.
%         
%         [dx, dy, min] = minCost(costs); % finds which macroblock in imgI gave us min Cost
%         vectors(1,mbCount) = dy-p-1;    % row co-ordinate for the vector
%         vectors(2,mbCount) = dx-p-1;    % col co-ordinate for the vector
%         mbCount = mbCount + 1;
%         costs = ones(2*p + 1, 2*p +1) * 65537;
%     end
% end
% 
% motionVect = vectors;
% %EScomputations = computations/(mbCount - 1);
           

%%%%% DALEXIAD CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
refframe = imgI;
newframe = imgP;
bsize = mbSize;
Vrange=p; Hrange=p;

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
                if ((r+v<1) || (r+v>Ny-(bsize-1)) || (c+h<1) || (c+h>Nx-(bsize-1)))
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

       

    end
end

motionVect = [reshape(vm,1,numel(vm));reshape(hm,1,numel(hm))];
