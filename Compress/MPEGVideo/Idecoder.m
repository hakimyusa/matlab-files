function [layer]= Idecoder(c,array,MatAC,MatDC)
layer=deRunLength(c,array,MatAC,MatDC);
%layer = inverseDCT(layer,DCT_trans,array);
%bufferImageI1=inverseDCT(layer,DCT_trans,array);
%imshow(uint8(bufferImageI1))
