
clear all
close all
clc
tic

aviobj = avifile('2.avi','fps',25,'COMPRESSION','None');
%motion Vectors
motionVect=zeros(2,256);
fid=fopen('Qtable2.txt','r');
%array is quantization matrix
array=fscanf(fid,'%e',[8,inf]);
%array=2*array;
array=array;

i = 0;
%flag to tell if B frame was predicted from I or P frame flag=1 P frame
%flag=0 I frame
flag=2;
%GOP is of 10 pictures IBBPBBPBBI
mov=aviread('news.avi');
movinfo=aviinfo('news.avi');
noframe=movinfo.NumFrames;
%mbSize macroblock size used for motion estimation
mbSize = 8;
%p for search area
p = 7;

global I1d P4d P7d I10d B2d B3d B5d B6d B8d B9d
framedata=aviread('news.avi',1);
I1=frame2im(framedata);
I1=imresize(I1,[128 128]);
%I1=rgb2gray(I1);

I1=double(I1);
JQ=forwardDCT(I1,array);
bufferI1 = inverseDCT(JQ,array);
c= makeLayers(JQ);

%%calling decoder
identifier=1;
decoder(c,motionVect,identifier,flag);
%%%this loop is for accessing frame from actual movie
for i=1:10:60
    i
    if i~=1
        j=i-round(i/10);
        [B2,B3,P4,B5,B6,P7,B8,B9,I10]=GOP(j);
    elseif i==1
        j=i;
        [B2,B3,P4,B5,B6,P7,B8,B9,I10]=GOP(j);
    end
        %processing on P4 frame
        [bufferP4,streamP4,motionVect]=compensatedFrame(P4,bufferI1,mbSize,p,array); 
        c= makeLayers(streamP4);

        %calling decoder
        identifier=4;
        %decoder(diffDC,valVectorBase,lenVectorBase,valVectorEnhan,lenVectorEnhan,identifier,flag,motionVect);
        decoder(c,motionVect,identifier,flag);



% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        
        %for B2    
        [B2t ,motionVect, flag] = bFrameProc(B2,bufferI1,bufferP4,0.5*array,mbSize,p);
        c= makeLayers(B2t);
        
        %calling decoder
        identifier=2;
        decoder(c,motionVect,identifier,flag);
        
        %for B3    
        [B3t ,motionVect ,flag] = bFrameProc(B3,bufferI1,bufferP4,0.5*array,mbSize,p);
        c= makeLayers(B3t);
        
        %calling decoder
        identifier=3;
        decoder(c,motionVect,identifier,flag);
 
        %predicting p7 from p4
        [bufferP7,streamP7,motionVect]=compensatedFrame(P7,bufferP4,mbSize,p,array);
        c= makeLayers(streamP7);
        
        %calling decoder
        identifier=7;
        decoder(c,motionVect,identifier,flag);
%          
        %for B5    
        [B5t motionVect flag] = bFrameProc(B5,bufferP4,bufferP7,0.5*array,mbSize,p);
        c= makeLayers(B5t);
        
        %calling decoder
        identifier=5;
        decoder(c,motionVect,identifier,flag);
   
        %for B6    
        [B6t motionVect flag] = bFrameProc(B6,bufferP4,bufferP7,0.5*array,mbSize,p);
        c= makeLayers(B6t);
        
        %calling decoder
        identifier=6;
        decoder(c,motionVect,identifier,flag);
 
        %processing on I10 frame
        streamI10=forwardDCT(I10,array);
        bufferI10 = inverseDCT(streamI10,array);
        c= makeLayers(streamI10);
        %%calling decoder
        identifier=10;
        decoder(c,motionVect,identifier,flag);
%         
        %for B8    
        [B8t motionVect flag] = bFrameProc(B8,bufferP7,bufferI10,0.5*array,mbSize,p);
        c= makeLayers(B8t);
        
        %calling decoder
        identifier=8;
        decoder(c,motionVect,identifier,flag);

        %for B9    
        [B9t motionVect flag] = bFrameProc(B9,bufferP7,bufferI10,0.5*array,mbSize,p);
        c= makeLayers(B9t);
        
        %calling decoder
        identifier=9;
        decoder(c,motionVect,identifier,flag);
    
%         
%         
        
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



        
    

        if i==1
                imshow(uint8(I1d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(B2d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(B3d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(P4d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(B5d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(B6d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(P7d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(B8d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(B9d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(I10d))
                aviobj = addframe(aviobj,getframe); 
                clf;
            else

                
                imshow(uint8(B2d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(B3d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(P4d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(B5d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(B6d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(P7d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(B8d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(B9d))
                aviobj = addframe(aviobj,getframe);
                clf;
                
                imshow(uint8(I10d))
                aviobj = addframe(aviobj,getframe);
                clf;
            end

            I1=I10;
            bufferI1=bufferI10;
            I1d=I10d;

end
aviobj = close(aviobj);
toc
