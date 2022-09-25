 function [B2,B3,P4,B5,B6,P7,B8,B9,I10]=GOP(i)
        %reading P4 frame
        framedata=aviread('news.avi',i+3);
        P4=frame2im(framedata);
        P4=imresize(P4,[128 128]);
        %P4=rgb2gray(P4);
        P4=double(P4);

   
        
        %reading B2 frame
        framedata=aviread('news.avi',i+1);
        B2=frame2im(framedata);
        B2=imresize(B2,[128 128]);
        %B2=rgb2gray(B2);
        B2=double(B2);
        %reading B3 frame
        framedata=aviread('news.avi',i+2);
        B3=frame2im(framedata);
        B3=imresize(B3,[128 128]);
        %B3=rgb2gray(B3);        
        B3=double(B3);
        %reading B5 frame
        framedata=aviread('news.avi',i+4);
        B5=frame2im(framedata);
        B5=imresize(B5,[128 128]);
        %B5=rgb2gray(B5);        
        B5=double(B5);
        %reading B6 frame
        framedata=aviread('news.avi',i+5);
        B6=frame2im(framedata);
        B6=imresize(B6,[128 128]);
        %B6=rgb2gray(B6);        
        B6=double(B6);
        %reading B8 frame
        framedata=aviread('news.avi',i+7);
        B8=frame2im(framedata);
        B8=imresize(B8,[128 128]);
        %B8=rgb2gray(B8);        
        B8=double(B8);
        %reading B9 frame
        framedata=aviread('news.avi',i+8);
        B9=frame2im(framedata);
        B9=imresize(B9,[128 128]);
        %B9=rgb2gray(B9);        
        B9=double(B9);
        %reading I10 frame
        framedata=aviread('news.avi',i+9);
        I10=frame2im(framedata);
        I10=imresize(I10,[128 128]);
        %I10=rgb2gray(I10);        
        I10=double(I10);

        %reading P7 frame
        framedata=aviread('news.avi',i+6);
        P7=frame2im(framedata);
        P7=imresize(P7,[128 128]);
        %P7=rgb2gray(P7);        
        P7=double(P7);