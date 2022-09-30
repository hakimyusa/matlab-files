function varargout = penjumlahan_citra(varargin)
% PENJUMLAHAN_CITRA MATLAB code for penjumlahan_citra.fig
%      PENJUMLAHAN_CITRA, by itself, creates a new PENJUMLAHAN_CITRA or raises the existing
%      singleton*.
%
%      H = PENJUMLAHAN_CITRA returns the handle to a new PENJUMLAHAN_CITRA or the handle to
%      the existing singleton*.
%
%      PENJUMLAHAN_CITRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PENJUMLAHAN_CITRA.M with the given input arguments.
%
%      PENJUMLAHAN_CITRA('Property','Value',...) creates a new PENJUMLAHAN_CITRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before penjumlahan_citra_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to penjumlahan_citra_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help penjumlahan_citra

% Last Modified by GUIDE v2.5 18-Sep-2021 10:29:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @penjumlahan_citra_OpeningFcn, ...
                   'gui_OutputFcn',  @penjumlahan_citra_OutputFcn, ...
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


% --- Executes just before penjumlahan_citra is made visible.
function penjumlahan_citra_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to penjumlahan_citra (see VARARGIN)

% Choose default command line output for penjumlahan_citra
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes penjumlahan_citra wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = penjumlahan_citra_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

open=guidata(gcbo);
A = get(open.axes1,'Userdata');
open=guidata(gcbo);
B = get(open.axes2,'Userdata');

    
    [r1,c1] = size(A);
    [r2,c2] = size(B);
    if (r1 == r2) && (c1 == c2)
    
        for x = 1 : r1
    
            for y = 1 : c1
    C(x,y) = A(x,y) + B(x,y);
    
    end
    
    end
    
    end
  set(open.figure1,'CurrentAxes',open.axes3);
set(imagesc(c));colormap('gray');
set(open.axes3,'Userdata',c);



% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

open=guidata(gcbo);
[namafile,direktori]=uigetfile({'*.jpg;*.bmp;*.tif'}, 'OpenImage');
I=imread(namafile);
set(open.figure1,'CurrentAxes',open.axes1);
set(imagesc(I));colormap('gray');
set(open.axes1,'Userdata',I);

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

open=guidata(gcbo);
[namafile,direktori]=uigetfile({'*.jpg;*.bmp;*.tif'}, 'OpenImage');
I=imread(namafile);
set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(I));colormap('gray');
set(open.axes2,'Userdata',I);

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
