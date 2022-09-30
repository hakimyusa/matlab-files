%This function performs down-sampling without prefiltering, then up-sampling with different method.
%Yao Wang  4/9/2003

function resize_exp(imgname)


original=imread(imgname);
[M,N]=size(original);
figure; imshow(original);title('original image');pause;
fimg=fftshift(fft2(original));
figure; 
imagesc(log(abs(fimg)+1));colormap(gray);truesize;title('DFT of original image')
pause;

d2_nf=imresize(original,0.5,'nearest');
figure;imshow(d2_nf);title('down-sampled w/o filtering');
pause;
fimg=fftshift(fft2(d2_nf));
figure; 
imagesc(log(abs(fimg)+1));colormap(gray);truesize;title('DFT of downsampled image w/o filtering')
pause;

u2_d2_nf_rep=imresize(d2_nf,2);
figure; imshow(u2_d2_nf_rep);title('up-sampled using nearest neighbor from down-sampled w/o filtering')
pause;
fimg=fftshift(fft2(u2_d2_nf_rep));
figure; 
imagesc(log(abs(fimg)+1));colormap(gray);truesize;
title('DFT of up-sampled using nearest neighbor from down-sampled w/o filtering');
pause;

u2_d2_nf_lin=imresize(d2_nf,2,'bilinear');
figure; imshow(u2_d2_nf_lin);title('up-sampled using bilinear from down-sampled w/o filtering')
pause;
fimg=fftshift(fft2(u2_d2_nf_lin));
figure; 
imagesc(log(abs(fimg)+1));colormap(gray);truesize;
title('DFT of up-sampled using bilinear from down-sampled w/o filtering');
pause;

u2_d2_nf_cubic=imresize(d2_nf,2,'bicubic');
figure; imshow(u2_d2_nf_cubic);title('up-sampled using bicubic from down-sampled w/o filtering')
pause;
fimg=fftshift(fft2(u2_d2_nf_lin));
figure; 
imagesc(log(abs(fimg)+1));colormap(gray);truesize;
title('DFT of up-sampled using bicubic from down-sampled w/o filtering');