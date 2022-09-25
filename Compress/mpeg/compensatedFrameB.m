function JQ1=compensatedFrameB(Im,bufferImage,mbSize,p,array,motionVect)

imgComp = motionComp(bufferImage, motionVect, mbSize);
%imgComp=double(imgComp);
%imageSubtract=Im-imgComp;
imageSubtract1=imsubtract(Im,imgComp);
imageSubtract2=imsubtract(imageSubtract1,128);
%imageSubtract=imageSubtract-128;
imageSubtract2=double(imageSubtract2);
%imageSubtract=imageSubtract-128;
JQ1=forwardDCT(imageSubtract2,array);
%JQ2=inverseDCT(JQ1,DCT_trans,array);
%figure;imshow(uint8(JQ2))
%bufferImageP=JQ2+imageSubtract1;
%bufferImageP=uint8(bufferImageP);
%bufferImageP=imadd(JQ2,imageSubtract1);