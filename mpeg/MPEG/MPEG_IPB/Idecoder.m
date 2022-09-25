function [layer]= Idecoder(X,B,array,MatAC,MatDC)
layer=deRunLength(X,B,array,MatAC,MatDC);
%layer = inverseDCT(layer,DCT_trans,array);
%bufferImageI1=inverseDCT(layer,DCT_trans,array);
%imshow(uint8(bufferImageI1))
