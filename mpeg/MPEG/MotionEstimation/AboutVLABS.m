function varargout = AboutVLABS(varargin)
% ABOUTVLABS M-file for AboutVLABS.fig
%      ABOUTVLABS, by itself, creates a new ABOUTVLABS or raises the existing
%      singleton*.
%
%      H = ABOUTVLABS returns the handle to a new ABOUTVLABS or the handle to
%      the existing singleton*.
%
%      ABOUTVLABS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABOUTVLABS.M with the given input arguments.
%
%      ABOUTVLABS('Property','Value',...) creates a new ABOUTVLABS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AboutVLABS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AboutVLABS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AboutVLABS

% Last Modified by GUIDE v2.5 10-Nov-2010 14:38:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AboutVLABS_OpeningFcn, ...
                   'gui_OutputFcn',  @AboutVLABS_OutputFcn, ...
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


% --- Executes just before AboutVLABS is made visible.
function AboutVLABS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AboutVLABS (see VARARGIN)

% Choose default command line output for AboutVLABS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AboutVLABS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AboutVLABS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes during object creation, after setting all properties.
function IHUBtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IHUBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
icon =imread('AboutLOGOS\IHUSchoolOfScience.png');
set(hObject,'CData',icon);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
icon =imread('AboutLOGOS\logo_DIA_VIOU.jpg');
set(hObject,'CData',icon);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
icon =imread('AboutLOGOS\VLABS.png');
set(hObject,'CData',icon);
