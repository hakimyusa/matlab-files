function [layer]= pDecoder(X,B,array,MatAC,MatDC,bufferImage,motionVect)
mbSize=16;
subP=deRunLength(X,B,array,MatAC,MatDC);
imgComp = motionComp(bufferImage, motionVect,mbSize);
layer=imgComp+subP;
