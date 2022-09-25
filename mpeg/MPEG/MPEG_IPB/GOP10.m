%%%%Loads the current Gropu of Pictures (GOP)
function handles=GOP10(handles)

warning off;
handles = ClearAllAxes(handles);

%%%The Group of Pictures (GOP) starts from the i-th frame
%%%It is the j-th GOP
j=round(get(handles.GOPSlider,'value'));
i=(j-1)*9+1;


[NY,NX] = wantedFrameSize();
imagedata = handles.imagedata;

%%%%The first frame will be decoded as a I frame
% framedata=aviread(imagedata,i);
% I1=frame2im(framedata);
% I1 = handles.mov
I1 = handles.mov(i).cdata;
I1=rgb2gray(I1); 
I1=imresize(I1,[NY NX]); 
handles.I1{j}=double(I1);

%reading B2 frame
% framedata=aviread(imagedata,i+1);
% B2=frame2im(framedata);
B2 = handles.mov(i+1).cdata;
B2=rgb2gray(B2);    
B2=imresize(B2,[NY NX]); 
handles.B2{j}=double(B2);

%reading B3 frame
% framedata=aviread(imagedata,i+2);
% B3=frame2im(framedata);
B3 = handles.mov(i+2).cdata;
B3=rgb2gray(B3);  
B3=imresize(B3,[NY NX]);      
handles.B3{j}=double(B3);

%reading P4 frame
% framedata=aviread(imagedata,i+3);
% P4=frame2im(framedata);
P4 = handles.mov(i+3).cdata;
P4=rgb2gray(P4); 
P4=imresize(P4,[NY NX]);
handles.P4{j}=double(P4);

%reading B5 frame
% framedata=aviread(imagedata,i+4);
% B5=frame2im(framedata);
B5 = handles.mov(i+4).cdata;
B5=rgb2gray(B5);  
B5=imresize(B5,[NY NX]);     
handles.B5{j}=double(B5);

%reading B6 frame
% framedata=aviread(imagedata,i+5);
% B6=frame2im(framedata);
B6 = handles.mov(i+5).cdata;
B6=rgb2gray(B6);    
B6=imresize(B6,[NY NX]);        
handles.B6{j}=double(B6);

%reading P7 frame
% framedata=aviread(imagedata,i+6);
% P7=frame2im(framedata);
P7 = handles.mov(i+6).cdata;
P7=rgb2gray(P7); 
P7=imresize(P7,[NY NX]);        
handles.P7{j}=double(P7);

%reading B8 frame
% framedata=aviread(imagedata,i+7);
% B8=frame2im(framedata);
B8 = handles.mov(i+7).cdata;
B8=rgb2gray(B8);   
B8=imresize(B8,[NY NX]);    
handles.B8{j}=double(B8);

%reading B9 frame
% framedata=aviread(imagedata,i+8);
% B9=frame2im(framedata);
B9 = handles.mov(i+8).cdata;
B9=rgb2gray(B9); 
B9=imresize(B9,[NY NX]);     
handles.B9{j}=double(B9);

%reading I10 frame
% framedata=aviread(imagedata,i+9);
% I10=frame2im(framedata);
I10 = handles.mov(i+9).cdata;
I10=rgb2gray(I10);   
I10=imresize(I10,[NY NX]);  
handles.I10{j}=double(I10);



%%%%% Construct a Temp video for the new ten frames
if isfield(handles,'Player1')
    if ishandle(handles.Player1) 
        close(handles.Player1); 
    end
end
% aviobj = avifile('Temp1.avi','fps',20,'COMPRESSION','None');
% aviobj = addframe(aviobj,im2frame(uint8(I1),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(B2),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(B3),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(P4),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(B5),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(B6),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(P7),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(B8),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(B9),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(I10),gray(256)));
% aviobj = close(aviobj);


%%%Delete the Output file 
% warning off;
% delete('Temp2.avi');
% warning on;

set(handles.DecodedFramesPanel,'title','Decoded Frames');



