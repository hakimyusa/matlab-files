%Programs for extracting sample frames from a interlaced sequence in YCbCr color coordinate, 
%down-sample Y to get progressive frames
%Convert YCbCr to RGB and to YIQ
%Assume the sequence is in MPEG420 format (704*480 Y pixels, 352*240 Cr/Cb pixels), saved in YUV format
%YUV format: save Y frame (480x704) first, followed by Cb (240x352), then Cr (240x352)
%Author:  Yao Wang 9/10/03

FID = fopen('mobilcal_mpeg420_frame5_8.YUV','r');
%This sequence contains 4 frames of the sequence only

%read 1 frame
[tempY,count]=fread(FID,[704,480*3/2],'uint8');

%extract Y component
tempY=tempY';
tempY1(1:480,:)=tempY(1:480,:);

%downsample tempY1 to be the same size as Cb and Cr
Yframe1=zeros(240,352);
Yframe1=(tempY1(1:2:480,1:2:704)+tempY1(1:2:480,2:2:704))/2;
%use averaging over the same line, but not across the lines because adjacent lines
%are from different fields.

%display frame1 Y
figure
imshow(uint8(Yframe1));
%imwrite(uint8(Yframe),'mobile_frame1_Y.jpg','JPG');

%extract Cb and Cr components
Cbframe1=zeros(240,352);
Cbframe1(1:2:240,1:352)=tempY(481:600,1:352);
Cbframe1(2:2:240,1:352)=tempY(481:600,353:704);
figure
imshow(uint8(Cbframe1));
%imwrite(uint8(Cbframe1),'mobile_frame1_Cb.jpg','JPG');
Crframe1=zeros(240,352);
Crframe1(1:2:240,1:352)=tempY(601:720,1:352);
Crframe1(2:2:240,1:352)=tempY(601:720,353:704);
figure
imshow(uint8(Crframe1));
%imwrite(uint8(Crframe1),'mobile_frame1_Cr.jpg','JPG');

%convert to RGB color coordinate
Yframe1=Yframe1-16;
Cbframe1=Cbframe1-128;
Crframe1=Crframe1-128;
Rframe=1.164*Yframe1+1.596*Crframe1;
Gframe=1.164*Yframe1-0.392*Cbframe1-0.813*Crframe1;
Bframe=1.164*Yframe1+2.017*Cbframe1;

rgbimage=zeros(240,352,3);
rgbimage(:,:,1)=Rframe;
rgbimage(:,:,2)=Gframe;
rgbimage(:,:,3)=Bframe;
figure;
imshow(uint8(rgbimage));
%imwrite(uint8(rgbimage),'mobile_frame1_RGB.jpg','JPG');

close all;

%convert RGB to YIQ
Yframe1=0.299*Rframe+0.587*Gframe+0.114*Bframe;
Iframe1=0.596*Rframe-0.275*Gframe-0.321*Bframe;
Qframe1=0.212*Rframe-0.523*Gframe+0.311*Bframe;

%convert Cb and Cr to I and Q
%cos(33^o)/1.14=0.8387/1.14=0.7357, sin(33^o)/2.03=0.5446/2.03=0.2683
%sin(33^o)/1.14=0.5446/1.14=0.4777, cos(33^o)/2.03=0.8387/2.03=0.4132
%Iframe1=0.7357*Crframe1-0.2683*Cbframe1;
%Qframe1=0.4777*Crframe1+0.4132*Cbframe1;

figure
imshow(uint8(Yframe1));
%imwrite(uint8(Yframe1),'mobile_frame1_YCbCr2RGB2Y.jpg','JPG');
figure
imshow(uint8(Iframe1+128));
%imwrite(uint8(Iframe1+128),'mobile_frame1_I.jpg','JPG');
figure
imshow(uint8(Qframe1+128));
%imwrite(uint8(Qframe1+128),'mobile_frame1_Q.jpg','JPG');

fclose(FID);