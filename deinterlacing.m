%Programs for deinterlacing 
%Assume the sequence is in MPEG420 format (704*480 Y pixels, 352*240 Cr/Cb pixels), saved in YUV format
%YUV format: save Y frame (480x704) first, followed by Cb (240x352), then Cr (240x352)
%Process only Y component
%Author:  Yao Wang 9/19/03

FID = fopen('mobilcal_mpeg420_frame5_8.YUV','r');
%This sequence contains 4 frames of the sequence only

%read 1 frame
[tempY,count]=fread(FID,[704,480*3/2],'uint8');

%extract Y component
tempY=tempY';
Yframe1(1:480,:)=tempY(1:480,:);
%display frame1 Y
figure
imshow(uint8(Yframe1)); title('Frame1 consisting of two fields');
%imwrite(uint8(Yframe),'mobile_frame1_Y.jpg','JPG');
%separating two fields save in Y11,Y12
Y11=Yframe1(1:2:480,:);
Y12=Yframe1(2:2:480,:);
figure
imshow(uint8(Y11));title('Field 1 of Frame1');
figure
imshow(uint8(Y12));title('Field 2 of Frame1');

%read 2nd frame
[tempY,count]=fread(FID,[704,480*3/2],'uint8');

%extract Y component
tempY=tempY';
Yframe2(1:480,:)=tempY(1:480,:);
%display frame1 Y
figure
imshow(uint8(Yframe2));title('Frame2 consisting of two fields');
%imwrite(uint8(Yframe),'mobile_frame1_Y.jpg','JPG');
Y21=Yframe2(1:2:480,:);
Y22=Yframe2(2:2:480,:);
figure
imshow(uint8(Y21));title('Field 1 of Frame2');
figure
imshow(uint8(Y12));title('Field 2 of Frame2');


pause;
close all;
fclose(FID);

%deinterlacing field12
Y12_lineaveraging=zeros(480,704);
Y12_lineaveraging(2:2:480,:)=Y12;
Y12_lineaveraging(1,:)=Y12_lineaveraging(2,:);
Y12_lineaveraging(3:2:479,:)=(Y12_lineaveraging(2:2:478,:)+Y12_lineaveraging(4:2:480,:))/2;
figure
imshow(uint8(Y12_lineaveraging));
title('Deinterlaced Field Using Line Averaging');

Y12_fieldaveraging=zeros(480,704);
Y12_fieldaveraging(2:2:480,:)=Y12;
Y12_fieldaveraging(1:2:480,:)=(Y11+Y21)/2;
figure
imshow(uint8(Y12_fieldaveraging));
title('Deinterlaced Field Using Field Averaging');


Y12_linefieldaveraging=zeros(480,704);
Y12_linefieldaveraging(2:2:480,:)=Y12;
Y12_linefieldaveraging(1:2:480,:)=(Y12_lineaveraging(1:2:480,:)+Y12_fieldaveraging(1:2:480,:))/2;
figure
imshow(uint8(Y12_linefieldaveraging));
title('Deinterlaced Field Using Line and Field Averaging');
