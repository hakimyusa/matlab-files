function varargout = tresholding(varargin)
% TRESHOLDING MATLAB code for tresholding.fig
%      TRESHOLDING, by itself, creates a new TRESHOLDING or raises the existing
%      singleton*.
%
%      H = TRESHOLDING returns the handle to a new TRESHOLDING or the handle to
%      the existing singleton*.
%
%      TRESHOLDING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRESHOLDING.M with the given input arguments.
%
%      TRESHOLDING('Property','Value',...) creates a new TRESHOLDING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tresholding_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tresholding_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tresholding

% Last Modified by GUIDE v2.5 04-Oct-2021 19:09:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tresholding_OpeningFcn, ...
                   'gui_OutputFcn',  @tresholding_OutputFcn, ...
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


% --- Executes just before tresholding is made visible.
function tresholding_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tresholding (see VARARGIN)

% Choose default command line output for tresholding
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tresholding wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tresholding_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

[name_file1,name_path1] = uigetfile( ...
{'*.bmp;*.jpg;*.tif','Files of type (*.bmp,*.jpg,*.tif)';
'*.bmp','File Bitmap (*.bmp)';...
'*.jpg','File jpeg (*.jpg)';
'*.tif','File Tif (*.tif)';
'*.*','All Files (*.*)'},...
'Open Image');
if ~isequal(name_file1,0)
handles.data1 = imread(fullfile(name_path1,name_file1));
guidata(hObject,handles);
axes(handles.axes1);
imshow(handles.data1);
else
return;
end

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

image1 = handles.data1;
gray = rgb2gray(image1);
axes(handles.axes2);
imshow(gray);
handles.data2 = gray;
guidata(h0bject,handles);

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

thresh = handles.data3;
[name_file_save,path_save] = uiputfile( ...
{'*.bmp','File Bitmap (*.bmp)';...
'*.jpg','File jpeg (*.jpg)';
'*.tif','File Tif (*.tif)';
'*.*','All Files (*.*)'},...
'Save Image');
if ~isequal(name_file_save,0)
imwrite(thresh,fullfile(path_save,name_file_save));
else
return
end

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)

gray = handles.data2;
value = get(handles.slider1,'value');
thresh = imcomplement(im2bw(gray,value/255));
axes(handles.axes2);
imshow(thresh);
handles.data3 = thresh;
guidata(hObject,handles);
set(handles.edit1,'String',value)

% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
