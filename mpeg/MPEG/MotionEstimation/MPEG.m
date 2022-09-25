function varargout = MPEG(varargin)
% MPEG M-file for MPEG.fig
%      MPEG, by itself, creates a new MPEG or raises the existing
%      singleton*.
%
%      H = MPEG returns the handle to a new MPEG or the handle to
%      the existing singleton*.
%
%      MPEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MPEG.M with the given input arguments.
%
%      MPEG('Property','Value',...) creates a new MPEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MPEG_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MPEG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MPEG

% Last Modified by GUIDE v2.5 10-Nov-2010 15:57:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MPEG_OpeningFcn, ...
                   'gui_OutputFcn',  @MPEG_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MPEG is made visible.
function MPEG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MPEG (see VARARGIN)

% Choose default command line output for MPEG
handles.output = hObject;


handles.VideoLoaded = false;
handles.encoded = false;
set(handles.OriginalImageAxis, 'Parent', handles.uipanel1);

% Update handles structure
guidata(hObject, handles);

draw_Toolbar(hObject,handles);
% UIWAIT makes MPEG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MPEG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenFile_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
{'*.avi; *.cif; *.mpeg ; *.mpg','Video Files (*.avi,*.cif, *.mpeg, *.mpg)'},...
   'Pick a file','../../videos/');
if ~isequal(filename,0)
    
    extens = lower(filename(end-2:end)); %%%The file extension

    fullname = fullfile(pathname, filename);
    if (strcmp(extens,'avi'))
        OperationOnTheFly(true,handles);
%             mov = aviread(fullname);
        vidObj = VideoReader(fullname);
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
        
        handles.VideoLoaded = true;
        handles.encoded = false;
        guidata(hObject, handles);
        
        VideoLoaded(handles);
        ShowConsecutiveFrames(handles);
    elseif ((strcmp(extens,'cif')))
        OperationOnTheFly(true,handles);
        
        MAX_NUM_OF_FRAMES_TO_READ=100;
        [im_seq_y] = func_read_cif_luminanance_only(fullname,MAX_NUM_OF_FRAMES_TO_READ);        
        N=size(im_seq_y,3);
        for (n=1:N)
            mov(n).cdata(:,:,1)=uint8(im_seq_y(:,:,n)); %%R
            mov(n).cdata(:,:,2)=uint8(im_seq_y(:,:,n)); %%G
            mov(n).cdata(:,:,3)=uint8(im_seq_y(:,:,n)); %%B
            mov(n).colormap=[];
        end
        OperationOnTheFly(false,handles);
            
        handles.mov=mov;
        handles.VideoLoaded = true;
        handles.encoded = false;
        
        guidata(hObject, handles);

        VideoLoaded(handles);
        ShowConsecutiveFrames(handles);
    elseif((strcmp(extens,'peg') || (strcmp(extens,'mpg'))))
        OperationOnTheFly(true,handles);
        cd('mmread');
            [video audio]=mmread(fullname,[],false,true);
        cd('..');
        OperationOnTheFly(false,handles);
        
        handles.mov=video.frames;
        handles.VideoLoaded = true;
        handles.encoded = false;
        
        guidata(hObject, handles);

        VideoLoaded(handles);
        ShowConsecutiveFrames(handles);
        
    end      
    
    
end






% --- Executes on button press in PauseBtn.
function PauseBtn_Callback(hObject, eventdata, handles)
% hObject    handle to PauseBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles structure with handles and user data (see GUIDATA)
handles.Play=false;
guidata(hObject, handles);


% --- Executes on slider movement.
function FrameSlider_Callback(hObject, eventdata, handles)
% hObject    handle to FrameSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

if (handles.IsBusy==false)
    ShowConsecutiveFrames(handles);

    if (handles.encoded == true)
        currentFrameNum=floor(get(handles.FrameSlider,'value'));
        %%%Show the current frame of the compressed Video
        axes(handles.CompressedImageAxes);
        im1 = handles.comprFrames(:,:,currentFrameNum); 
        imshow(im1);
    end
end


% --- Executes during object creation, after setting all properties.
function FrameSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FrameSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function FrameEdit_Callback(hObject, eventdata, handles)
% hObject    handle to FrameEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FrameEdit as text
%        str2double(get(hObject,'String')) returns contents of FrameEdit as a double


% --- Executes during object creation, after setting all properties.
function FrameEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FrameEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% % --- Executes on button press in EncodeBtn.
% function EncodeBtn_Callback(hObject, eventdata, handles)
% % hObject    handle to EncodeBtn (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% EncodeMPEG(handles);




% --- Executes on selection change in BlockSizePopup.
function BlockSizePopup_Callback(hObject, eventdata, handles)
% hObject    handle to BlockSizePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns BlockSizePopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BlockSizePopup


% --- Executes during object creation, after setting all properties.
function BlockSizePopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BlockSizePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in SearchAccuracyPopup.
function SearchAccuracyPopup_Callback(hObject, eventdata, handles)
% hObject    handle to SearchAccuracyPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SearchAccuracyPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SearchAccuracyPopup


% --- Executes during object creation, after setting all properties.
function SearchAccuracyPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SearchAccuracyPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in SearchRangePopup.
function SearchRangePopup_Callback(hObject, eventdata, handles)
% hObject    handle to SearchRangePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns SearchRangePopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SearchRangePopup


% --- Executes during object creation, after setting all properties.
function SearchRangePopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SearchRangePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in BlockMatchingBtn.
function BlockMatchingBtn_Callback(hObject, eventdata, handles)
% hObject    handle to BlockMatchingBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.VideoLoaded)
    currentFrameNum=floor(get(handles.FrameSlider,'value'));

    im1 = handles.mov(currentFrameNum).cdata; 
    im1=double(rgb2gray(im1))/256;

    im2 = handles.mov(currentFrameNum+1).cdata; 
    im2=double(rgb2gray(im2))/256;

    if (get(handles.DoMotionEstimationCheck,'value')~=0)
      ShowBlockMatching(im1,im2,handles);
    end
end



% --- Executes on button press in DoMotionEstimationCheck.
function DoMotionEstimationCheck_Callback(hObject, eventdata, handles)
% hObject    handle to DoMotionEstimationCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DoMotionEstimationCheck





function BlockMatchingMAEEdit_Callback(hObject, eventdata, handles)
% hObject    handle to BlockMatchingMAEEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BlockMatchingMAEEdit as text
%        str2double(get(hObject,'String')) returns contents of BlockMatchingMAEEdit as a double


% --- Executes during object creation, after setting all properties.
function BlockMatchingMAEEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BlockMatchingMAEEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BlockMatchingPSNREdit_Callback(hObject, eventdata, handles)
% hObject    handle to BlockMatchingPSNREdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BlockMatchingPSNREdit as text
%        str2double(get(hObject,'String')) returns contents of BlockMatchingPSNREdit as a double


% --- Executes during object creation, after setting all properties.
function BlockMatchingPSNREdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BlockMatchingPSNREdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumOfMVsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfMVsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfMVsEdit as text
%        str2double(get(hObject,'String')) returns contents of NumOfMVsEdit as a double


% --- Executes during object creation, after setting all properties.
function NumOfMVsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfMVsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in MPEGPSearchAlgorithPopup.
function MPEGPSearchAlgorithPopup_Callback(hObject, eventdata, handles)
% hObject    handle to MPEGPSearchAlgorithPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns MPEGPSearchAlgorithPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from MPEGPSearchAlgorithPopup


% --- Executes during object creation, after setting all properties.
function MPEGPSearchAlgorithPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MPEGPSearchAlgorithPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end







function NumOfFramesEdit_Callback(hObject, eventdata, handles)
% hObject    handle to NumOfFramesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumOfFramesEdit as text
%        str2double(get(hObject,'String')) returns contents of NumOfFramesEdit as a double


% --- Executes during object creation, after setting all properties.
function NumOfFramesEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumOfFramesEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in IHULOGOBtn.
function IHULOGOBtn_Callback(hObject, eventdata, handles)
% hObject    handle to IHULOGOBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://www.tech.ihu.edu.gr/','-browser'); 

% --- Executes during object creation, after setting all properties.
function IHULOGOBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IHULOGOBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
icon =imread('icons/IHULogo6.jpg');
set(hObject,'CData',icon);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
% cd('../../..');
delete(hObject);
