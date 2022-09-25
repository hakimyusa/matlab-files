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

% Last Modified by GUIDE v2.5 10-Nov-2010 15:58:41

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

handles.imagedata = ''; %%%%%The original avifile


% handles.NY = 144;      
% handles.NX = 192;
% handles.NY=48;
% handles.NX=64;

quantizationTable = 'Qtable2.txt';
fid=fopen(quantizationTable,'r');
handles.array=fscanf(fid,'%e',[8,inf]);

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
{'*.avi','AVI Files (*.avi)'},...
   'Pick a file','../../videos/');
if ~isequal(filename,0)
    OperationOnTheFly(true,handles);
    extens = lower(filename(end-2:end)); %%%The file extension
    fullname = fullfile(pathname, filename);
    if (strcmp(extens,'avi'))
                
        handles.imagedata=fullname;        
        handles=VideoLoaded(handles);
        handles=GOP10(handles);
        
        
        handles = DoCurrentOperation(handles);
        
        guidata(hObject, handles);
    end
    OperationOnTheFly(false,handles);
end



% --- Executes on slider movement.
function GOPSlider_Callback(hObject, eventdata, handles)
% hObject    handle to GOPSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

j=round(get(handles.GOPSlider,'value'));
i=(j-1)*9+1;
set(handles.FrameEdit,'string',[num2str(i) ' to ' num2str(i+9)]);
handles=GOP10(handles);
%%%Reset the Operation Sliders
set(handles.operationSlider,'value',1);
set(handles.operationEdit,'string','1');
handles = DoCurrentOperation(handles);
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function GOPSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GOPSlider (see GCBO)
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




% --- Executes on slider movement.
function operationSlider_Callback(hObject, eventdata, handles)
% hObject    handle to operationSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
curOperation=round(get(handles.operationSlider,'value'));
set(handles.operationEdit,'string',num2str(curOperation));
handles = DoCurrentOperation(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function operationSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to operationSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end





function operationEdit_Callback(hObject, eventdata, handles)
% hObject    handle to operationEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of operationEdit as text
%        str2double(get(hObject,'String')) returns contents of operationEdit as a double


% --- Executes during object creation, after setting all properties.
function operationEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to operationEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in ShowInOrigBtn.
function ShowInOrigBtn_Callback(hObject, eventdata, handles)
% hObject    handle to ShowInOrigBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ShowInDecoded1Btn.
function ShowInDecoded1Btn_Callback(hObject, eventdata, handles)
% hObject    handle to ShowInDecoded1Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ShowInDecoded2Btn.
function ShowInDecoded2Btn_Callback(hObject, eventdata, handles)
% hObject    handle to ShowInDecoded2Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ViewOriginalBtn.
function ViewOriginalBtn_Callback(hObject, eventdata, handles)
% hObject    handle to ViewOriginalBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Player1 = Player1;
guidata(hObject, handles);

% --- Executes on button press in ViewEncodedBtn.
function ViewEncodedBtn_Callback(hObject, eventdata, handles)
% hObject    handle to ViewEncodedBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ex = exist('temp2.avi','file');
if (~ex)
   msgbox('Please take all steps of encoding...','Error','error')  
else
   handles.Player2 = player2;
   guidata(hObject, handles);
end




% --- Executes on button press in IHULogoBtn.
function IHULogoBtn_Callback(hObject, eventdata, handles)
% hObject    handle to IHULogoBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://www.tech.ihu.edu.gr/','-browser'); 

% --- Executes during object creation, after setting all properties.
function IHULogoBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IHULogoBtn (see GCBO)
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
