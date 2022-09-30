function varargout = testing(varargin)
% TESTING MATLAB code for testing.fig
%      TESTING, by itself, creates a new TESTING or raises the existing
%      singleton*.
%
%      H = TESTING returns the handle to a new TESTING or the handle to
%      the existing singleton*.
%
%      TESTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTING.M with the given input arguments.
%
%      TESTING('Property','Value',...) creates a new TESTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testing

% Last Modified by GUIDE v2.5 20-Oct-2021 01:26:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testing_OpeningFcn, ...
                   'gui_OutputFcn',  @testing_OutputFcn, ...
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


% --- Executes just before testing is made visible.
function testing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testing (see VARARGIN)

% Choose default command line output for testing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)

popvalue = get(handles.popupmenu1,'value')

if (popvalue == 1)
    
    open=guidata(gcbo);
I = get(open.axes1,'Userdata');

j = im2bw(I);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);

elseif(popvalue == 2)
    
    open=guidata(gcbo);
I = get(open.axes1,'Userdata');

j = rgb2gray(I);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);
    
elseif(popvalue == 3)
    
    open=guidata(gcbo);
I = get(open.axes1,'Userdata');

j = ([255-I]);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);

elseif(popvalue == 4)
    
    open=guidata(gcbo);
I = get(open.axes1,'Userdata');

j = rgb2ycbcr(I);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);

elseif(popvalue == 5)
    
    open=guidata(gcbo);
I = get(open.axes1,'Userdata');

k=imresize(I,[512 512]);
j=im2double(k);


set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);

elseif(popvalue == 6)
    
    open=guidata(gcbo);
I = get(open.axes1,'Userdata');

j=rgb2ntsc(I);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);

elseif(popvalue == 7)
    
    open=guidata(gcbo);
I = get(open.axes1,'Userdata');

j= rgb2hsv(I);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);

elseif(popvalue == 8)
    
    open=guidata(gcbo);
I = get(open.axes1,'Userdata');

j= imsharpen(I);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);

elseif(popvalue == 9)
    
    open=guidata(gcbo);
I = get(open.axes1,'Userdata');

j = imgaussfilt(I,3);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);

elseif(popvalue == 10)
    
    open=guidata(gcbo);
I = get(open.axes1,'Userdata');

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);
end

% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)

open=guidata(gcbo);
I = get(open.axes1,'Userdata');

j = im2bw(I);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);

% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)



% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

open=guidata(gcbo);
[namafile,direktori]=uigetfile({'*.jpg;*.bmp;*.tif;*.png;'}, 'Open Image');
I=imread(namafile);
set(open.figure1,'CurrentAxes',open.axes1);
set(imagesc(I));colormap('gray');
set(open.axes1,'Userdata',I);


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)



% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popupmenu1.
function popupmenu2_Callback(hObject, eventdata, handles)

open=guidata(gcbo);
I = get(open.axes1,'Userdata');

j = im2bw(I);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(j));colormap('gray');
set(open.axes2,'Userdata',j);


% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)

% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)

% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
