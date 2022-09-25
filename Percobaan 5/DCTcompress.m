function varargout = DCTcompress(varargin)
% DCTCOMPRESS MATLAB code for DCTcompress.fig
%      DCTCOMPRESS, by itself, creates a new DCTCOMPRESS or raises the existing
%      singleton*.
%
%      H = DCTCOMPRESS returns the handle to a new DCTCOMPRESS or the handle to
%      the existing singleton*.
%
%      DCTCOMPRESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DCTCOMPRESS.M with the given input arguments.
%
%      DCTCOMPRESS('Property','Value',...) creates a new DCTCOMPRESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DCTcompress_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DCTcompress_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DCTcompress

% Last Modified by GUIDE v2.5 07-Oct-2018 22:00:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DCTcompress_OpeningFcn, ...
                   'gui_OutputFcn',  @DCTcompress_OutputFcn, ...
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
end

% --- Executes just before DCTcompress is made visible.
function DCTcompress_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for DCTcompress
handles.output = hObject;

     set(handles.axes1,'visible', 'off');
     set(handles.axes2,'visible', 'off');

% Update handles structure
guidata(hObject, handles);
end


% --- Outputs from this function are returned to the command line.
function varargout = DCTcompress_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
end

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
end

% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
printdlg(handles.figure1)
end

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end
delete(handles.figure1)
end

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
end

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end
end



% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
    handles = guidata(hObject);

    [handles.ImageFile,handles.folder] = uigetfile();
    handles.fullFileName = fullfile(handles.folder, handles.ImageFile);
    [handles.filepath,handles.fName,~] = fileparts(handles.ImageFile);
    addpath(handles.folder)
    handles.Image = imread(fullfile(handles.ImageFile));

    handles.ext = '.png';
    
    axes(handles.axes1);
    imshow(handles.Image);
    axes(handles.axes2);
    cla;
               
    guidata(hObject,handles);
end

% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
    handles = guidata(hObject);
    try
        sName = strcat(fullfile(handles.folder,handles.saveName),handles.ext)
        imwrite(handles.Cimage,sName);
    catch
    end
    
    guidata(hObject,handles);
end

% --- Executes on button press in Compress_Max.
function Compress_Max_Callback(hObject, eventdata, handles)
    handles = guidata(hObject);
    
    handles.Cimage = DCT_Compress_Fcn(handles.ImageFile,1);
    handles.saveName = strcat(handles.fName,'_OutMax');
    axes(handles.axes2);
    imshow(handles.Cimage);
    
    guidata(hObject,handles);
end

% --- Executes on button press in Compress_Med.
function Compress_Med_Callback(hObject, eventdata, handles)
    handles = guidata(hObject);
    
    handles.Cimage = DCT_Compress_Fcn(handles.ImageFile,2);
    handles.saveName = strcat(handles.fName,'_OutMed');
    axes(handles.axes2);
    imshow(handles.Cimage);
    
    guidata(hObject,handles);
end

% --- Executes on button press in Compress_Min.
function Compress_Min_Callback(hObject, eventdata, handles)
    handles = guidata(hObject);
    
    handles.Cimage = DCT_Compress_Fcn(handles.ImageFile,3);
    handles.saveName = strcat(handles.fName,'_OutMin');
    axes(handles.axes2);
    imshow(handles.Cimage);
    
    guidata(hObject,handles);
end

% --- Executes on button press in Compress_None.
function Compress_None_Callback(hObject, eventdata, handles)
    handles = guidata(hObject);
    
    handles.Cimage = DCT_Compress_Fcn(handles.ImageFile,4);
    handles.saveName = strcat(handles.fName,'_OutNone');
    axes(handles.axes2);
    imshow(handles.Cimage);
    
    guidata(hObject,handles);
end