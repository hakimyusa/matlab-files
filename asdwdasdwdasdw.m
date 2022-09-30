function varargout = asdwdasdwdasdw(varargin)
% ASDWDASDWDASDW MATLAB code for asdwdasdwdasdw.fig
%      ASDWDASDWDASDW, by itself, creates a new ASDWDASDWDASDW or raises the existing
%      singleton*.
%
%      H = ASDWDASDWDASDW returns the handle to a new ASDWDASDWDASDW or the handle to
%      the existing singleton*.
%
%      ASDWDASDWDASDW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASDWDASDWDASDW.M with the given input arguments.
%
%      ASDWDASDWDASDW('Property','Value',...) creates a new ASDWDASDWDASDW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before asdwdasdwdasdw_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to asdwdasdwdasdw_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help asdwdasdwdasdw

% Last Modified by GUIDE v2.5 28-Sep-2021 18:04:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @asdwdasdwdasdw_OpeningFcn, ...
                   'gui_OutputFcn',  @asdwdasdwdasdw_OutputFcn, ...
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


% --- Executes just before asdwdasdwdasdw is made visible.
function asdwdasdwdasdw_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to asdwdasdwdasdw (see VARARGIN)

% Choose default command line output for asdwdasdwdasdw
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes asdwdasdwdasdw wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = asdwdasdwdasdw_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
