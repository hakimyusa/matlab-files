function [bufferImageP,subFrame]=pFrameCal(DCT_trans,Im,array,bufferImageI,mbSize,p);
[bufferImageP,subFrame]=compensatedFrame(Im,bufferImageI,mbSize,p,DCT_trans,array);

