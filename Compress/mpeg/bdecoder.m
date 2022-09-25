function layer= bDecoder(c,array,MatAC,MatDC,bufferImage,motionVect)
mbSize=8;
bufferImage=double(bufferImage);
sub=deRunLength(c,array,MatAC,MatDC);
imgComp = motionComp(bufferImage, motionVect,mbSize);
layer=imadd((imadd(imgComp,sub)),128);

