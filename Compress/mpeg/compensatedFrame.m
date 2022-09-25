function [bufferImageP,streamP,motionVect]=compensatedFrame(Im,bufferImage,mbSize,p,array)

motionVect = motionEstTSS(Im,bufferImage,mbSize,p);
imgComp = motionComp(bufferImage, motionVect, mbSize);
imageSubtract=double(imsubtract(uint8(Im),uint8(imgComp)));
streamP=forwardDCT(imageSubtract,array);
JQ2=inverseDCT(streamP,array);


%imageSubtract2=double(imageSubtract2);
%imageSubtract=imageSubtract-128;



%figure;imshow(uint8(JQ2))
%bufferImageP=JQ2+imageSubtract1;
%bufferImageP=uint8(bufferImageP);
bufferImageP=double(imadd(JQ2,imgComp));