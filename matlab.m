function varargout = matlab(varargin)
% MATLAB MATLAB code for matlab.fig
%      MATLAB, by itself, creates a new MATLAB or raises the existing
%      singleton*.
%
%      H = MATLAB returns the handle to a new MATLAB or the handle to
%      the existing singleton*.
%
%      MATLAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATLAB.M with the given input arguments.
%
%      MATLAB('Property','Value',...) creates a new MATLAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before matlab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to matlab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help matlab

% Last Modified by GUIDE v2.5 11-Jul-2020 14:49:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @matlab_OpeningFcn, ...
                   'gui_OutputFcn',  @matlab_OutputFcn, ...
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


% --- Executes just before matlab is made visible.
function matlab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to matlab (see VARARGIN)

% Choose default command line output for matlab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes matlab wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = matlab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function namafile_Callback(hObject, eventdata, handles)
% hObject    handle to namafile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of namafile as text
%        str2double(get(hObject,'String')) returns contents of namafile as a double


% --- Executes during object creation, after setting all properties.
function namafile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to namafile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in cari.
function cari_Callback(hObject, eventdata, handles)
% hObject    handle to cari (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%browse file
[filename,pathname] = uigetfile('*.jpg','Pilih File');
%cek file name
if isequal([filename,pathname],[0,0])
return 
else
fullpath = fullfile(pathname,filename);
handles.gui.fullpath = fullpath;
handles.gui.filename = filename;
handles.gui.pathname = pathname;
%tuliskan nama file pada bagian edit text
set(handles.namafile,'String',handles.gui.fullpath);
guidata(hObject, handles);
end


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% tampilkan citra
addpath(handles.gui.pathname);
I = imread(handles.gui.filename);
handles.gui.I = I;
imshow(I);
guidata(hObject, handles);


% --- Executes on slider movement.
function brightness_Callback(hObject, eventdata, handles)
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% get slider value
brightness_value = get(hObject,'Value');
% process
I_edit = handles.gui.I;
bright_I(:,:,1) = uint8( bound( double(I_edit(:,:,1)) + brightness_value ));
bright_I(:,:,2) = uint8( bound( double(I_edit(:,:,2)) + brightness_value ) ) ;
bright_I(:,:,3) = uint8( bound( double(I_edit(:,:,3)) + brightness_value ) ) ;
handles.gui.bright_I = bright_I;
imshow(bright_I);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function brightness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function contrast_Callback(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% get slider value
contrast_value = get(hObject,'Value');
% process
if contrast_value ~= 0
cv = contrast_value / 2;
contrast_value = 127 ^ (cv / 100);
I_edit = handles.gui.I;
contrast_I(:,:,1) = uint8( bound( round( (double(I_edit(:,:,1))-128)*contrast_value + 128 ) ) );
contrast_I(:,:,2) = uint8( bound( round( (double(I_edit(:,:,2))-128)*contrast_value + 128 ) ) );
contrast_I(:,:,3) = uint8( bound( round( (double(I_edit(:,:,3))-128)*contrast_value + 128 ) ) );
end;
handles.gui.contrast_I = contrast_I;
imshow(contrast_I);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in bright_ok.
function bright_ok_Callback(hObject, eventdata, handles)
% hObject    handle to bright_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.brightness,'Value',0);
handles.gui.I = handles.gui.bright_I;
guidata(hObject, handles);


% --- Executes on button press in contrast_ok.
function contrast_ok_Callback(hObject, eventdata, handles)
% hObject    handle to contrast_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.contrast,'Value',0);
handles.gui.I = handles.gui.contrast_I;
guidata(hObject, handles);


% --- Executes on button press in simpan.
function simpan_Callback(hObject, eventdata, handles)
% hObject    handle to simpan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% command simpan file
[FileName, PathName] = uiputfile('.jpg', 'Save As');
if PathName==0
return; 
end
Name = fullfile(PathName, FileName);
imwrite(handles.gui.I, Name, 'jpg');
guidata(hObject, handles);


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
