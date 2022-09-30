%sample program for doing DFT domain filtering
%using specified image and filter mask
% Yao Wang  4/2/2003


S=zeros(4,4);
S=[9,1,9,1;1,9,1,9;9,1,9,1;1,9,1,9]
DFS=fft2(S)
W=zeros(4,4);
W(1,1)=1;
W
DFS1=W.*DFS
S1=ifft2(DFS1)
real(S1)

% Note that for the filtered image to be real valued, 
% the  DFT mask (W) must satisfy a certain conjugate symmetry condition
% It is possible that you get a filtered image with complex values if the
% mask you specified does not satisfy this condition.