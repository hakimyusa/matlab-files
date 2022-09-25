function handles = VideoLoaded(handles)

        vidObj = VideoReader(handles.imagedata);
        vidHeight = vidObj.Height;
        vidWidth = vidObj.Width;
        s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
        'colormap',[]);
        k = 1;
        while hasFrame(vidObj)
            s(k).cdata = readFrame(vidObj);
            k = k+1;
        end
        OperationOnTheFly(false,handles);
        handles.mov=s;


%%%Change the GOP Slider Settings
videoInfo = aviinfo(handles.imagedata);
N=videoInfo.NumFrames;

N1=floor((N-1)/9);   %%%%Because we must use 10 by 10 the frames in this GUI
set(handles.GOPSlider,'visible','on');
set(handles.GOPSlider,'min',1);
set(handles.GOPSlider,'max',N1);
set(handles.GOPSlider,'value',1);
set(handles.GOPSlider,'SliderStep',[1/N1 1/N1]);
set(handles.FrameEdit,'string',['1 to 10']);
set(handles.NumOfFramesEdit,'string',['from ',num2str(N)]);

%%%Reset the Operation Sliders
set(handles.operationSlider,'value',1);
set(handles.operationEdit,'string','1');



%%Set visible the various controls, that were initially invisible
set(handles.NumOfFramesEdit,'visible','on');
set(handles.text1,'visible','on');
set(handles.FrameEdit,'visible','on');
set(handles.text26,'visible','on');
set(handles.operationSlider,'visible','on');
set(handles.operationEdit,'visible','on');
set(handles.ViewOriginalBtn,'visible','on');
set(handles.ViewEncodedBtn,'visible','on');

%%%%%Reset all the handle variables, associated with a video
handles.I1=[]; handles.B2=[]; handles.B3=[]; handles.P4=[]; handles.B5=[];
handles.B6=[]; handles.P7=[]; handles.B8=[]; handles.B9=[]; handles.I10=[];

handles.I1d=[]; handles.B2d=[]; handles.B3d=[]; handles.P4d=[]; handles.B5d=[];
handles.B6d=[]; handles.P7d=[]; handles.B8d=[]; handles.B9d=[]; handles.I10d=[];

