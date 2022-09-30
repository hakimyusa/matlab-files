function varargout = uts(varargin)
% UTS MATLAB code for uts.fig
%      UTS, by itself, creates a new UTS or raises the existing
%      singleton*.
%
%      H = UTS returns the handle to a new UTS or the handle to
%      the existing singleton*.
%
%      UTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UTS.M with the given input arguments.
%
%      UTS('Property','Value',...) creates a new UTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before uts_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to uts_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help uts

% Last Modified by GUIDE v2.5 20-Oct-2021 04:07:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @uts_OpeningFcn, ...
                   'gui_OutputFcn',  @uts_OutputFcn, ...
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


% --- Executes just before uts is made visible.
function uts_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to uts (see VARARGIN)

% Choose default command line output for uts
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes uts wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = uts_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

open=guidata(gcbo);
[namafile,direktori]=uigetfile({'*.jpg;*.bmp;*.tif'}, 'OpenImage');
I=imread(namafile);
set(open.figure1,'CurrentAxes',open.axes1);
set(imagesc(I));colormap('gray');
set(open.axes1,'Userdata',I);

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


I3 = I;
I2 = I;
I1 = I;

I1(:,:,2:3)=0;
RED = I1;

I2(:,:,1:2) = 0;
BLUE = I2;

I3(:,:,1:3)=0;
GREEN=I3;

tic;
figure;imshow(RED);
figure;imshow(BLUE);
figure;imshow(GREEN);
c = 255-RED;
m = 255-GREEN;
y = 255-BLUE;
figure;imshow(c);
figure;imshow(m);
figure;imshow(y);

end

% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

open=guidata(gcbo);
I = get(open.axes1,'Userdata');
I2 = flipdim(I ,2);


subplot(2,2,1), imshow(I)
subplot(2,2,2), imshow(I2)


set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(I2));colormap('gray');
set(open.axes2,'Userdata',I2);



% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

open=guidata(gcbo);
I = get(open.axes1,'Userdata');
I3 = flipdim(I ,1);
I4 = flipdim(I3,2);


subplot(2,2,1), imshow(I)
subplot(2,2,2), imshow(I4)


set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(I4));colormap('gray');
set(open.axes2,'Userdata',I4);

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

axes(handles.axes2);
toBeSaved=getframe(gca);
[fileName, filePath] = uiputfile('*.bmp', 'Save As');
fileName = fullfile(filePath,fileName); 
imwrite(toBeSaved.cdata, fileName, 'bmp');
guidata(hObject,handles);

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)

% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% get slider value
brightness_value = get(hObject,'Value');
% process
I_edit = handles.gui.I;
bright_I(:,:,1) = uint8( bound( double(I_edit(:,:,1)) + brightness_value ));
bright_I(:,:,2) = uint8( bound( double(I_edit(:,:,2)) + brightness_value ) ) ;
bright_I(:,:,3) = uint8( bound( double(I_edit(:,:,3)) + brightness_value ) ) ;
handles.gui.bright_I = bright_I;
imshow(bright_I);
guidata(hObject, handles);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(I2));colormap('gray');
set(open.axes2,'Userdata',I2);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function texto_Callback(hObject, eventdata, handles)
edit=get(hObject,'string');
set(handles.slider,'value',str2num(edit));
guidata(hObject,handles);
axes(handles.axes2)
val=0.5*get(handles.axes2, 'value')-0.5;
imbright=(handles.axes2)+val;
imshow(imbright);
axes(handles.axes2);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(I2));colormap('gray');
set(open.axes2,'Userdata',I2);

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)

contrast_value = get(hObject,'Value');
% process
if contrast_value ~= 0
cv = contrast_value / 2;
contrast_value = 127 ^ (cv / 100);
I_edit = handles.gui.I;
contrast_I(:,:,1) = uint8( bound( round( (double(I_edit(:,:,1))-128)*contrast_value + 128 ) ) );
contrast_I(:,:,2) = uint8( bound( round( (double(I_edit(:,:,2))-128)*contrast_value + 128 ) ) );
contrast_I(:,:,3) = uint8( bound( round( (double(I_edit(:,:,3))-128)*contrast_value + 128 ) ) );
end;
handles.gui.contrast_I = contrast_I;
guidata(hObject, handles);

set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(contrast_I));colormap('gray');
set(open.axes2,'Userdata',contrast_I);

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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)

I = handles.Img;
red=I(:,:,1);
a = zeros(size(I, 1), size(I, 2));
J = cat(3,red,a,a);
axes(handles.axes2);
imshow(J);
handles.data2 = J;
guidata(hObject,handles)


% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
