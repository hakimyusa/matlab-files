
% Input
%   imgP : The image for which we want to find motion vectors
%   imgI : The reference image
%   mbSize : Size of the macroblock
%   p : Search parameter  (read literature to find what this means)
%
% Output
%   motionVect : the motion vectors for each integral macroblock in imgP



function [motionVect, zeroCount] = BmotionEstARPS(imgP, imgI, mbSize, p)

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



zeroCount=0;
sizeVect=size(motionVect);
for i=1:sizeVect(2)
    if motionVect(1,i)==0 & motionVect(2,i)==0
        zeroCount=zeroCount+1;
    end
end    
    



% zeroCount=0;
% [row col] = size(imgI);
% 
% vectors = zeros(2,row*col/mbSize^2);
% costs = ones(1, 6) * 65537;
% 
% 
% % The index points for Small Diamond search pattern
% SDSP(1,:) = [ 0 -1];
% SDSP(2,:) = [-1  0];
% SDSP(3,:) = [ 0  0];
% SDSP(4,:) = [ 1  0];
% SDSP(5,:) = [ 0  1];
% 
% % We will be storing the positions of points where the checking has been
% % already done in a matrix that is initialised to zero. As one point is
% % checked, we set the corresponding element in the matrix to one. 
% 
% checkMatrix = zeros(2*p+1,2*p+1);
% 
% % computations = 0;
% 
% % we start off from the top left of the image
% % we will walk in steps of mbSize
% % mbCount will keep track of how many blocks we have evaluated
% 
% mbCount = 1;
% for i = 1 : mbSize : row-mbSize+1
%     for j = 1 : mbSize : col-mbSize+1
%         
%         % the Adapive Rood Pattern search starts
%         % we are scanning in raster order
%         
%         x = j;
%         y = i;
%         
%         costs(3) = costFuncMAD(imgP(i:i+mbSize-1,j:j+mbSize-1), ...
%                                     imgI(i:i+mbSize-1,j:j+mbSize-1),mbSize);
%         
%         checkMatrix(p+1,p+1) = 1;
% %         computations =  computations + 1; 
%         % if we are in the left most column then we have to make sure that
%         % we just do the LDSP with stepSize = 2
%         if (j-1 < 1)
%             stepSize = 2;
%             maxIndex = 5;
%         else 
%             stepSize = max(abs(vectors(1,mbCount-1)), abs(vectors(2,mbCount-1)));
% 
%             % now we have to make sure that if the point due to motion
%             % vector is one of the LDSP points then we dont calculate it
%             % again
%             if ( (abs(vectors(1,mbCount-1)) == stepSize & vectors(2,mbCount-1) == 0) ...
%                  | (abs(vectors(2,mbCount-1)) == stepSize & vectors(1,mbCount-1) == 0)) ...
%                  
%                 maxIndex = 5; % we just have to check at the rood pattern 5 points
%                 
%             else
%                 maxIndex = 6; % we have to check 6 points
%                 LDSP(6,:) = [ vectors(2, mbCount-1)  vectors(1, mbCount-1)];
%             end
%         end
%         
%         % The index points for first and only Large Diamond search pattern
%         
%         LDSP(1,:) = [ 0 -stepSize];
%         LDSP(2,:) = [-stepSize 0]; 
%         LDSP(3,:) = [ 0  0];
%         LDSP(4,:) = [stepSize  0];
%         LDSP(5,:) = [ 0  stepSize];
%         
%         
%         % do the LDSP
%         
%         
%         for k = 1:maxIndex
%             refBlkVer = y + LDSP(k,2);   % row/Vert co-ordinate for ref block
%             refBlkHor = x + LDSP(k,1);   % col/Horizontal co-ordinate
%             if ( refBlkVer < 1 | refBlkVer+mbSize-1 > row ...
%                  | refBlkHor < 1 | refBlkHor+mbSize-1 > col)
%              
%                 continue; % outside image boundary
%             end
% 
%             if (k == 3 | stepSize == 0)
%                 continue; % center point already calculated
%             end
%             costs(k) = costFuncMAD(imgP(i:i+mbSize-1,j:j+mbSize-1), ...
%                   imgI(refBlkVer:refBlkVer+mbSize-1, refBlkHor:refBlkHor+mbSize-1), mbSize);
% %             computations =  computations + 1;
%             checkMatrix(LDSP(k,2) + p+1, LDSP(k,1) + p+1) = 1;
%             
%         end
%         
%         [cost, point] = min(costs);
%         
%         
%         % The doneFlag is set to 1 when the minimum
%         % is at the center of the diamond           
% 
%         x = x + LDSP(point, 1);
%         y = y + LDSP(point, 2);
%         costs = ones(1,5) * 65537;
%         costs(3) = cost;
%        
% 
%         doneFlag = 0;   
%         while (doneFlag == 0)
%             for k = 1:5
%                 refBlkVer = y + SDSP(k,2);   % row/Vert co-ordinate for ref block
%                 refBlkHor = x + SDSP(k,1);   % col/Horizontal co-ordinate
%                 if ( refBlkVer < 1 | refBlkVer+mbSize-1 > row ...
%                       | refBlkHor < 1 | refBlkHor+mbSize-1 > col)
%                       continue;
%                 end
% 
%                 if (k == 3)
%                     continue
%                 elseif (refBlkHor < j-p | refBlkHor > j+p | refBlkVer < i-p ...
%                             | refBlkVer > i+p)
%                         continue;
%                 elseif (checkMatrix(y-i+SDSP(k,2)+p+1 , x-j+SDSP(k,1)+p+1) == 1)
%                     continue
%                 end
%             
%                 costs(k) = costFuncMAD(imgP(i:i+mbSize-1,j:j+mbSize-1), ...
%                              imgI(refBlkVer:refBlkVer+mbSize-1, ...
%                                  refBlkHor:refBlkHor+mbSize-1), mbSize);
%                 checkMatrix(y-i+SDSP(k,2)+p+1, x-j+SDSP(k,1)+p+1) = 1;
% %                 computations =  computations + 1;
%                 
%   
%             end
%             
%             [cost, point] = min(costs);
%            
%             if (point == 3)
%                 doneFlag = 1;
%             else
%                 x = x + SDSP(point, 1);
%                 y = y + SDSP(point, 2);
%                 costs = ones(1,5) * 65537;
%                 costs(3) = cost;
%             end
%             
%         end  % while loop ends here
%         
%         vectors(1,mbCount) = y - i;    % row co-ordinate for the vector
%         vectors(2,mbCount) = x - j;    % col co-ordinate for the vector            
%         mbCount = mbCount + 1;
%         costs = ones(1,6) * 65537;
%         
%         checkMatrix = zeros(2*p+1,2*p+1);
%     end
% end
%     
% motionVect = vectors;
 