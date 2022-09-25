function [bufferImageP,streamP,motionVect]=compensatedFrame(Im,bufferImage,mbSize,p,array,estAlgo)



if estAlgo == 1
    motionVect = motionEstARPS(Im,bufferImage,mbSize,p);
elseif estAlgo == 2
    motionVect = motionEstDS(Im,bufferImage,mbSize,p);
elseif estAlgo == 3
    motionVect = motionEstES(Im,bufferImage,mbSize,p);
elseif estAlgo == 4
    motionVect = motionEstTSS(Im,bufferImage,mbSize,p);
end

imgComp = motionComp(bufferImage, motionVect, mbSize);
imageSubtract=Im-imgComp;
streamP=forwardDCT(imageSubtract,array);
JQ2=inverseDCT(streamP,array);


bufferImageP=JQ2+imgComp;


