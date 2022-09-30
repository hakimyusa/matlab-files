%Programs for extracting sample interlaced frames and fields from a interlaced sequence
%Assume the sequence is in MPEG420 format (704*480 Y pixels, 352*240 Cr/Cb pixels), saved in YUV format
%YUV format: save Y frame first, followed by Cb, then Cr
%Author:  Xiaofeng Xu, 8/30/03, Modified by Yao Wang 9/5/03

FID = fopen('mobilcal_mpeg420_frame5_8.YUV','r');
%This sequence contains 4 frames of the sequence only

[tempY,count]=fread(FID,[704,480*3/2],'uint8');

tempY=tempY';
tempY1(1:480,:)=tempY(1:480,:);

%display frame1
figure
imshow(uint8(tempY1));
imwrite(uint8(tempY1),'mobile_frame1.jpg','JPG');

%extract and display top and bottom files
%top field

top_field(1:240,:)=tempY1(1:2:480,:);
figure
imshow(uint8(top_field));
imwrite(uint8(top_field),'mobile_field_top.jpg','JPG');

%bottom field
bottom_field(1:240,:)=tempY1(2:2:480,:);
figure
imshow(uint8(bottom_field));
imwrite(uint8(bottom_field),'mobile_field_bottom.jpg','JPG');

%convert the field data to a 1D vector (raster)
Y_vector_top=im2col(top_field',[1,1],'distinct');
Y_vector_bottom=im2col(bottom_field',[1,1],'distinct');


%read next frame
[tempY_next,count]=fread(FID,[704,480*3/2],'uint8');

tempY_next=tempY_next';
tempY2(1:480,:)=tempY_next(1:480,:);
top_field(1:240,:)=tempY2(1:2:480,:);
bottom_field(1:240,:)=tempY2(2:2:480,:);
Y_vector_top2=im2col(top_field',[1,1],'distinct');
Y_vector_bottom2=im2col(bottom_field',[1,1],'distinct');

%This vector contain raster data from 2 frames
Y_vector=[Y_vector_top,Y_vector_bottom, Y_vector_top2,Y_vector_bottom2,];

fclose(FID);

%plot the raster waveform for first 5 lines

figure;
Fs=30*704*480; %sampling rate
plot([0:1/Fs:704*5/Fs-1/Fs],Y_vector(1:704*5));
ylabel('Gray Level');
xlabel('Time');
title('Waveform of a Raster Video (5 lines)')
axis tight;

%compute and plot the spectrum
figure;
%using FFT window size of 10 lines to compute the spectrum
%when using 1 line only, does not show the periodic structure
%when using 20 lines, not enough averaging, more noisy then 10 lines
[P,F]=spectrum(Y_vector,704*10,0,hanning(704*10),Fs);
semilogy(F,P(:,1));
axis tight
title('Spectrum of a raster video')
legend('Line rate=30*480')

figure;
semilogy(F,P(:,1));
axis([0,20*30*480,0,10E6])
title('Detailed view of the spectrum (begining 20 cyles)');
legend('Line rate=30*480')

fclose(FID);