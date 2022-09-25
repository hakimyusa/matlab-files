function pred = MC(xref,vx,vy,N);
% Motion compensation/prediction for image coding.
% pred = MC(xref,vx,vy,N);
% 
% Parameters
%   xref : reference image
%   vx   : motion vector x-direction
%   vy   : motion vector y-direction
%   N    : block size
% Output
%   pred : The predicted image

[r,k]=size(xref);
pred = xref;

for ii=1:r/N,
	for jj=1:k/N,
        ix1 = (1+(ii-1)*N:(ii*N));
        ix2 = (1+(jj-1)*N:(jj*N));
        pred(ix1, ix2) = xref(ix1+vy(ii,jj), ix2+vx(ii,jj));
   end;
end;

