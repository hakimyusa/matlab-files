function HPF_image(inimgname,W1,W2)
% This function performs ideal high-pass filtering in the DFT domain.
% The highpass filter mask = 1- lowpass mask
% The user can specify the image name and the DFT window size for the lowpass mask.
% Your image should be graylevel only, must be in one of the format supported by matlab. 
% Type "help imread" to find out what formats are supported.
% Usage:  HPF_image(inimgname,vertical_window_width,horizontal_window_width)
% inimagename should be typed with a single quotation mark.
% Example: HPF_image('lena.bmp',50,50)
% Yao Wang, 4/2/2003

close all; %close all current opened windows.


A=imread(inimgname);
[M,N]=size(A)

figure; imagesc(A); colormap(gray(256)); axis image;


pm=floor(log2(M));pn=floor(log2(N));
M1=2^pm; N1=2^pn;
M1,N1;

DFA=fft2(A,M1,N1);
figure; imagesc(log(abs(fftshift(DFA))+1));colormap(gray(256));axis image;

title('DFT Magnitude of the image');

if ((W1>M1/2) |(W2>N1/2))
   disp('Window size must be less than half of image height and width, W1<M1/2,W2<N1/2')
   return;
end;

r1=zeros(M1,1);
r1(1:W1+1,1)=1;r1(M1-W1+1:M1,1)=1;
r2=zeros(N1,1);
r2(1:W2+1,1)=1;r2(N1-W2+1:N1,1)=1;
w=r1*r2';
w=1-w;

figure; imagesc(fftshift(w)); colormap(gray(256));axis image;

title('Windowed DFT Magnitude'); title('The DFT Filter Window');

DFB=w.*DFA;
figure; imagesc(log(abs(fftshift(DFB))+1));colormap(gray(256));axis image;

title('Windowed DFT Magnitude');

B=real(ifft2(DFB,M1,N1));
figure; imagesc(B);colormap(gray(256));axis image;
title('Filtered image');

