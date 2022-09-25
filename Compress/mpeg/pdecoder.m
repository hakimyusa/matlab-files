function [layer]= pDecoder(c,array,MatAC,MatDC,bufferImage,motionVect)
mbSize=8;
subP=deRunLength(c,array,MatAC,MatDC);
imgComp = motionComp(bufferImage, motionVect,mbSize);
layer=double(imadd(imgComp,subP));
