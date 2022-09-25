function ShowConsecutiveFrames(handles)

OperationOnTheFly(true,handles);


currentFrameNum=floor(get(handles.FrameSlider,'value'));
set(handles.FrameEdit,'string',num2str(currentFrameNum));

%%%Show the current (anchor) frame
axes(handles.OriginalImageAxis);
im1 = handles.mov(currentFrameNum).cdata; 
im1=double(rgb2gray(im1))/256;
imshow(im1, 'Parent', handles.OriginalImageAxis);

%%%Show the next (target) frame
axes(handles.NextFrameAxes);
im2 = handles.mov(currentFrameNum+1).cdata; 
im2=double(rgb2gray(im2))/256;
imshow(im2);

OperationOnTheFly(false,handles);


if (get(handles.DoMotionEstimationCheck,'value')~=0)
  ShowBlockMatching(im1,im2,handles);
end
    
    