function varargout = guide_2(varargin)
% GUIDE_2 MATLAB code for guide_2.fig
%      GUIDE_2, by itself, creates a new GUIDE_2 or raises the existing
%      singleton*.
%
%      H = GUIDE_2 returns the handle to a new GUIDE_2 or the handle to
%      the existing singleton*.
%
%      GUIDE_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDE_2.M with the given input arguments.
%
%      GUIDE_2('Property','Value',...) creates a new GUIDE_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guide_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guide_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guide_2

% Last Modified by GUIDE v2.5 18-Sep-2021 10:18:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guide_2_OpeningFcn, ...
                   'gui_OutputFcn',  @guide_2_OutputFcn, ...
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


% --- Executes just before guide_2 is made visible.
function guide_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guide_2 (see VARARGIN)

% Choose default command line output for guide_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guide_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guide_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

open=guidata(gcbo);
[namafile,direktori]=uigetfile({'*.jpg;*.bmp;*.tif'}, 'OpenImage');
I=imread(namafile);
set(open.figure1,'CurrentAxes',open.axes1);
set(imagesc(I));colormap('gray');
set(open.axes1,'Userdata',I);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

open=guidata(gcbo);
I = imread(namafile);
function J = clipping(I)
for x = 1 : size(I,1)
for y = 1 : size(I,2)
if I(x,y) > 255
J(x,y) = 255;
elseif I(x,y) < 0
J(x,y) = 0;
else
J(x,y) = I(x,y);
end
end
end
set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(J));colormap('gray');
set(open.axes2,'Userdata',J);
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
