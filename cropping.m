function varargout = cropping(varargin)
% CROPPING MATLAB code for cropping.fig
%      CROPPING, by itself, creates a new CROPPING or raises the existing
%      singleton*.
%
%      H = CROPPING returns the handle to a new CROPPING or the handle to
%      the existing singleton*.
%
%      CROPPING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CROPPING.M with the given input arguments.
%
%      CROPPING('Property','Value',...) creates a new CROPPING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cropping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cropping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cropping

% Last Modified by GUIDE v2.5 28-Sep-2021 15:14:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cropping_OpeningFcn, ...
                   'gui_OutputFcn',  @cropping_OutputFcn, ...
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


% --- Executes just before cropping is made visible.
function cropping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cropping (see VARARGIN)

% Choose default command line output for cropping
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cropping wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cropping_OutputFcn(hObject, eventdata, handles) 
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
I = get(namafile);
[brs kol] = size(I);
x1 = 186; 
x2 = 911; 
y1 = 105 
y2 = 810; 
xmin = x1; 
ymin = y1; 
width = x2-x1; 
height = y2-y1; 
I3 = imcrop(gambar, [xmin ymin width height]); 
imshow(I3,'parent',handles.axes2); 
title('Cropping Image');

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
