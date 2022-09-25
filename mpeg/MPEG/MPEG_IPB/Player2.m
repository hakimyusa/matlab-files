function varargout = Player2(varargin)
% PLAYER2 M-file for Player2.fig
%      PLAYER2, by itself, creates a new PLAYER2 or raises the existing
%      singleton*.
%
%      H = PLAYER2 returns the handle to a new PLAYER2 or the handle to
%      the existing singleton*.
%
%      PLAYER2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLAYER2.M with the given input arguments.
%
%      PLAYER2('Property','Value',...) creates a new PLAYER2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Player2_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Player2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Player2

% Last Modified by GUIDE v2.5 20-May-2010 14:15:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Player2_OpeningFcn, ...
                   'gui_OutputFcn',  @Player2_OutputFcn, ...
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


% --- Executes just before Player2 is made visible.
function Player2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Player2 (see VARARGIN)

% Choose default command line output for Player2
handles.output = hObject;
set(handles.activex1,'url','temp2.avi');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Player2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Player2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
