function varargout = cropping2(varargin)
% CROPPING2 MATLAB code for cropping2.fig
%      CROPPING2, by itself, creates a new CROPPING2 or raises the existing
%      singleton*.
%
%      H = CROPPING2 returns the handle to a new CROPPING2 or the handle to
%      the existing singleton*.
%
%      CROPPING2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CROPPING2.M with the given input arguments.
%
%      CROPPING2('Property','Value',...) creates a new CROPPING2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cropping2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cropping2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cropping2

% Last Modified by GUIDE v2.5 04-Oct-2021 18:22:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cropping2_OpeningFcn, ...
                   'gui_OutputFcn',  @cropping2_OutputFcn, ...
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


% --- Executes just before cropping2 is made visible.
function cropping2_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cropping2 (see VARARGIN)

% Choose default command line output for cropping2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cropping2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cropping2_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, ~, handles)

[nama_file,nama_path] = uigetfile({'.jpg';'.bmp';'.png';'.tif';},'Buka 
Gambar'); 
if ~isequal (nama_file,0) 
    handles.data1 = imread(fullfile(nama_path,nama_file)); 
    guidata(hObject,handles); 
    axes(handles.axes1); 
    imshow(handles.data1); 
    title('Gambar Asli'); 
else 
    return 
end 

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(~, ~, handles)

gambar = handles.data1; 
x1 = 186; 
x2 = 911; 
y1 = 105; 
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
