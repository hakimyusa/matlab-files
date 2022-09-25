function ConstructEncodedVideo(handles)

j=round(get(handles.GOPSlider,'value'));

%%%%% Construct a Temp video for the new ten frames
if isfield(handles,'Player2')
    if ishandle(handles.Player2) 
        close(handles.Player2); 
    end
end

%%%%% Construct a Temp video for the new ten frames
warning off;
% aviobj = avifile('Temp2.avi','fps',20,'COMPRESSION','None');
% aviobj = addframe(aviobj,im2frame(uint8(handles.I1d{j}),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(handles.B2d{j}),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(handles.B3d{j}),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(handles.P4d{j}),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(handles.B5d{j}),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(handles.B6d{j}),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(handles.P7d{j}),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(handles.B8d{j}),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(handles.B9d{j}),gray(256)));
% aviobj = addframe(aviobj,im2frame(uint8(handles.I10d{j}),gray(256)));
% aviobj = close(aviobj);
warning on;

sum1=0;
for (id=1:10)
    sum1=sum1+handles.XX{j,id} + handles.BB{j,id};
end
mean1=sum1/numel(handles.I1{j})/10;
set(handles.DecodedFramesPanel,'title',['Decoded Frames - ',num2str(mean1),' bits/pixel']);
