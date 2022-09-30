

%For each image block, perform DCT, quantization and inverse DCT
%User can specify the QP for quantization
%Yao Wang, 4/10/2003
%This program calls function "blkdct_quant"

function dct_exp(fname,QP)


img=imread(fname);
qimg=blkproc(img,[8 8],'blkdct_quant',QP);
figure;
imagesc(qimg),axis image, truesize, axis off; colormap(gray);
title('DCT Domain Quantized Image');
