function layer= bDecoder(X,B,array,MatAC,MatDC,bufferImage,motionVect)
mbSize=16;
bufferImage=double(bufferImage);
sub=deRunLength(X,B,array,MatAC,MatDC);
imgComp = motionComp(bufferImage, motionVect,mbSize);
layer=imgComp+sub+128;
