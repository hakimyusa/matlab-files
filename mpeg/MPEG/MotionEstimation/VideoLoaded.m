function [] = VideoLoaded(handles)




%%%Change the Frame Slider Settings
N=length(handles.mov);
set(handles.FrameSlider,'visible','on');
set(handles.FrameSlider,'min',1);
set(handles.FrameSlider,'max',N-1);
set(handles.FrameSlider,'value',1);
set(handles.FrameSlider,'SliderStep',[1/(N-1) 0.01]);


set(handles.NumOfFramesEdit,'visible','on');
set(handles.NumOfFramesEdit,'string',['of ',num2str(N)]);


set(handles.text1,'visible','on');
set(handles.FrameEdit,'visible','on');
set(handles.BlockMatchingBtn,'enable','on');




