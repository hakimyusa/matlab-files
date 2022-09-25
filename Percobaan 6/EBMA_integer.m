% Exhuastive search block matching algorithm with integer accuracy
% Modified from me.m by Bo Tao, Princeton University
% Modified by Yao Wang, Polytechnic University, 10/8/2003

function [vm,hm,pframe]=EBMA_integer(refframe, newframe, row, col, bsize, vrange, hrange, vm, hm, pframe)
%compute the motion field between new frame and refframe

%vm and hm stores  an initial motion field, return with the computed
%motion field
%pframe stores an initial predicted frame, return with the final predicted
%frame using computed motion field

bsize1=bsize-1;

%br and bc are block indices
%r and c are the row and column index of the left corner of a block
br=0;
for r=1:bsize:row-bsize1
   br=br+1;
   bc=0;
   for c=1:bsize:col-bsize1
      bc=bc+1;
      
      %assuming vm,hm store initial motion field
      %first compare the current block with the candidate block associated with the initial MV
      %use the resulting error as the initial minimum error
      v0=vm(br,bc);
      h0=hm(br,bc);
      x=newframe(r:r+bsize1, c:c+bsize1)-refframe(r+v0:r+v0+bsize1, c+h0:c+h0+bsize1);
      err0=sum(sum(abs(x)));
      minerr=err0;
      vmin=v0;hmin=h0;   
      
      %next compare with all candidate blocks in the search region centered around the initial MV
      %and determine the candidate block that has the least error and the corresponding MV
      for v=-vrange+v0:vrange+v0
         for h=-hrange+h0:hrange+h0
            if ((r+v>=1) & (r+v<=row-bsize1) & (c+h>=1) & (c+h<=col-bsize1))
               %only do comparison if the candidate block is within the image range
               x=newframe(r:r+bsize1, c:c+bsize1)- ...
                  refframe(r+v:r+v+bsize1, c+h:c+h+bsize1);
               err=sum(sum(abs(x))); 
               if (err<minerr)
                  minerr=err;
                  hmin=h; vmin=v;
               end;     
            end
         end     %the motion search window    
      end
      
      if (minerr>(err0-100))%favor  initial MV if the new error is not less than err0 by 100.
         hmin=h0;
         vmin=v0;
         minerr=err0;
      end;
      
      %store the resulting motion vector in motion field
      vm(br,bc)=vmin;
      hm(br,bc)=hmin;
     
      %copy the best matching candidate block to pframe
      pframe(r:r+bsize1, c:c+bsize1)=refframe(r+vmin:r+vmin+bsize1, c+hmin:c+hmin+bsize1);
      
   end
   %display results for the last block of each row 
   disp([r,c,br,bc,vmin, hmin, minerr]);
end

