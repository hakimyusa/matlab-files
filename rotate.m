function varargout = rotate(varargin)
% ROTATE MATLAB code for rotate.fig
%      ROTATE, by itself, creates a new ROTATE or raises the existing
%      singleton*.
%
%      H = ROTATE returns the handle to a new ROTATE or the handle to
%      the existing singleton*.
%
%      ROTATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROTATE.M with the given input arguments.
%
%      ROTATE('Property','Value',...) creates a new ROTATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rotate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rotate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rotate

% Last Modified by GUIDE v2.5 04-Oct-2021 18:50:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rotate_OpeningFcn, ...
                   'gui_OutputFcn',  @rotate_OutputFcn, ...
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


% --- Executes just before rotate is made visible.
function rotate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rotate (see VARARGIN)

% Choose default command line output for rotate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rotate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rotate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

handles.output=hObject;
[a b]=uigetfile({'*.*'});
img=imread([b a]);
imshow(img,'Parent',handles.axes1);
rotate=imrotate(img,90);
imshow(rotate,'Parent',handles.axes2);
title('Hasil Putar 90 Derajat');
guidata(hObject,handles);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

handles.output=hObject;
[a b]=uigetfile({'*.*'});
img=imread([b a]);
imshow(img,'Parent',handles.axes1);
rotate=imrotate(img,180);
imshow(rotate,'Parent',handles.axes2);
title('Hasil Putar 180 Derajat');
guidata(hObject,handles);

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
