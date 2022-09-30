function varargout = Terang_Gelap(varargin)
% TERANG_GELAP M-file for Terang_Gelap.fig
%      TERANG_GELAP, by itself, creates a new TERANG_GELAP or raises the existing
%      singleton*.
%
%      H = TERANG_GELAP returns the handle to a new TERANG_GELAP or the handle to
%      the existing singleton*.
%
%      TERANG_GELAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TERANG_GELAP.M with the given input arguments.
%
%      TERANG_GELAP('Property','Value',...) creates a new TERANG_GELAP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Terang_Gelap_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Terang_Gelap_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
 
% Edit the above text to modify the response to help Terang_Gelap
 
% Last Modified by GUIDE v2.5 01-Jan-2013 17:27:42
 
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Terang_Gelap_OpeningFcn, ...
    'gui_OutputFcn',  @Terang_Gelap_OutputFcn, ...
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
 
 
% --- Executes just before Terang_Gelap is made visible.
function Terang_Gelap_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Terang_Gelap (see VARARGIN)
 
% Choose default command line output for Terang_Gelap
handles.output = hObject;
movegui(hObject,'center')
% Update handles structure
guidata(hObject, handles);
 
% UIWAIT makes Terang_Gelap wait for user response (see UIRESUME)
% uiwait(handles.figure1);
 
 
% --- Outputs from this function are returned to the command line.
function varargout = Terang_Gelap_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Get default command line output from handles structure
varargout{1} = handles.output;
 
 
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.slider1,'value',0);
[name_file1,name_path1] = uigetfile( ...
    {'*.bmp;*.jpg;*.tif','Files of type (*.bmp,*.jpg,*.tif)';
    '*.bmp','File Bitmap (*.bmp)';...
    '*.jpg','File jpeg (*.jpg)';
    '*.tif','File Tif (*.tif)';
    '*.*','All Files (*.*)'},...
    'Open Image');
 
if ~isequal(name_file1,0)
    handles.data1 = imread(fullfile(name_path1,name_file1));
    axes(handles.axes1);
    imshow(handles.data1);
    axes(handles.axes2);
    imshow(handles.data1);
    info = imfinfo(fullfile(name_path1,name_file1));
    bitdepth = info.BitDepth;
    handles.bitdepth = bitdepth;
    guidata(hObject,handles);
else
    return;
end
 
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);
 
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
nilai_slider = get(handles.slider1,'value');
citra = double(handles.data1);
 
bitdepth = handles.bitdepth;
[m,n,~] = size(handles.data1);
 
if bitdepth == 8
    for i = 1:m
        for j = 1:n
            citra(i,j) = citra(i,j)+nilai_slider;
            if citra(i,j) > 255
                citra(i,j) = 255;
            end;
            if citra(i,j) < 0
                citra(i,j) = 0;
            end;
        end;
    end;
elseif bitdepth == 24
    for x = 1:3
        for i = 1:m
            for j = 1:n
                citra(i,j,x) = citra(i,j,x)+nilai_slider;
                if citra(i,j,x) > 255
                    citra(i,j,x) = 255;
                end;
                if citra(i,j,x) < 0
                    citra(i,j,x) = 0;
                end;
            end;
        end;
    end
else
    msgbox('Citra masukan harus grayscale atau RGB');
end
 
axes(handles.axes2);
gambar = uint8(citra);
imshow(gambar);
 
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end