function varargout = aplikasi_editing(varargin)
% APLIKASI_EDITING MATLAB code for aplikasi_editing.fig
%      APLIKASI_EDITING, by itself, creates a new APLIKASI_EDITING or raises the existing
%      singleton*.
%
%      H = APLIKASI_EDITING returns the handle to a new APLIKASI_EDITING or the handle to
%      the existing singleton*.
%
%      APLIKASI_EDITING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APLIKASI_EDITING.M with the given input arguments.
%
%      APLIKASI_EDITING('Property','Value',...) creates a new APLIKASI_EDITING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aplikasi_editing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aplikasi_editing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aplikasi_editing

% Last Modified by GUIDE v2.5 20-Oct-2021 05:40:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aplikasi_editing_OpeningFcn, ...
                   'gui_OutputFcn',  @aplikasi_editing_OutputFcn, ...
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


% --- Executes just before aplikasi_editing is made visible.
function aplikasi_editing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aplikasi_editing (see VARARGIN)

% Choose default command line output for aplikasi_editing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes aplikasi_editing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aplikasi_editing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=get(hObject,'Value');
Img=handles.Img;
Img=Img+x;
axes(handles.axes2); cla; imshow(Img)
set(handles.slider3,'String',num2str(x));
handles.Img=Img;
updateg4(handles)
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


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x=get(hObject,'Value');
Img=handles.Img;
Img=Img.*x;
axes(handles.axes2); cla; imshow(Img)
set(handles.axes2,'String',num2str(x));
handles.Img=Img;
updateg4(handles) 
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
image1 = handles.Img;
red=image1(:,:,1);
a = zeros(size(image1, 1), size(image1, 2));
merah = cat(3,red,a,a);
axes(handles.axes2);
imshow(merah);
handles.data2 = merah;
guidata(hObject,handles)
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
image1 = handles.Img;
green=image1(:,:,1);
a = zeros(size(image1, 1), size(image1, 2));
hijau = cat(3,a,green,a);
axes(handles.axes2);
imshow(hijau);
handles.data2 = hijau;
guidata(hObject,handles);
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


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image1 = handles.Img;
blue=image1(:,:,1);
a = zeros(size(image1, 1), size(image1, 2));
biru = cat(3,a,a,blue);
axes(handles.axes2);
imshow(biru);
handles.data2 = biru;
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'.'});

if ~isequal(filename,0)
    Img = imread(fullfile(pathname,filename));
    info = imfinfo(fullfile(pathname,filename));
    bitdepth = info.BitDepth;
    if bitdepth ==24
        axes(handles.axes1)
        imshow(Img)
        set(handles.popupmenu1,'enable','on')
        set(handles.popupmenu1,'Value',1)
    else
        errordlg('Image must be RGB','File Error');
    end
else
    return
end
 
handles.Img = Img;
guidata(hObject, handles);

% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
input = str2double(get(handles.edit1, 'String'));

ccwise = imrotate(Img, input ,'bilinear','crop');   
axes(handles.axes2)
imshow(ccwise)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on button press in togglebutton5.
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
input = str2double(get(handles.edit1, 'String'));

cwise = imrotate(Img, 360 - input ,'bilinear','crop');   
axes(handles.axes2)
imshow(cwise)
% Hint: get(hObject,'Value') returns toggle state of togglebutton5


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
val = get(hObject,'Value');
 
switch val
    case 1 %sharpening
        Sharpening = imsharpen(Img);   
        axes(handles.axes2)
        imshow(Sharpening)
    
    case 2 %smoothing
        Smoothing = imgaussfilt(Img,2);   
        axes(handles.axes2)
        imshow(Smoothing)
    
    case 3 %rgb to grayscale
        Grayscale = rgb2gray(Img);   
        axes(handles.axes2)
        imshow(Grayscale)
   
    case 4 %rgb to black white
        BW = im2bw(Img)   
        axes(handles.axes2)
        imshow(BW)
        
    case 5 %rgb to negative
        Negatif = imcomplement(Img);
        R = Negatif(:,:,1);
        G = Negatif(:,:,2);
        B = Negatif(:,:,3);
        axes(handles.axes2)
        imshow(Negatif)
       
    case 6 % rgb to cmy
        CMY = im2double(Img);
        R=CMY(:,:,1);
        G=CMY(:,:,2);
        B=CMY(:,:,3);
        C=1-R;
        M=1-G;
        Y=1-B;
        CMY=cat(3,C,M,Y);
        axes(handles.axes2)
        imshow(CMY)
        
    case 7 % rgb to HSI
        HSI = rgb2hsv(Img);
        axes(handles.axes2)
        imshow(HSI)
        
    case 8 % rgb to ycbcr
        YCbCr = rgb2ycbcr(Img);
        axes(handles.axes2)
        imshow(YCbCr)
        
    case 9 % rgb to yiq
        YIQ = rgb2ntsc(Img);
        axes(handles.axes2)
        imshow(YIQ)
        
    case 10 % rgb to yuv
        YUV = rgb2ycbcr(Img);
        axes(handles.axes2)
        imshow(YUV)
       
end
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


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
fliphori = flipdim(Img, 2);   
axes(handles.axes2)
imshow(fliphori)
% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
flipverti = flipdim(Img, 1);   
axes(handles.axes2)
imshow(flipverti)
% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton7.
function togglebutton7_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton7


% --- Executes on button press in togglebutton8.
function togglebutton8_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton8



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


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
imageProc = handles.data1;
value = get(handles.sliderBrightnes,'value');
thresh = imageProc + value;
axes(handles.axes2);
imshow(thresh);
handles.data3 = thresh;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = handles.Img;
input = str2double(get(handles.edit1, 'String'));

ccwise = imrotate(Img, input ,'bilinear','crop');   
axes(handles.axes2)
imshow(ccwise)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Img = handles.Img;
input = str2double(get(handles.edit1, 'String'));

cwise = imrotate(Img, 360 - input ,'bilinear','crop');   
axes(handles.axes2)
imshow(cwise)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
hold off;
cla reset;
axes(handles.axes2);
hold off;
cla reset;

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Saveimg = getframe(handles.axes2);
img = frame2im(Saveimg);
startingFolder = userpath % Or "pwd" or wherever you want.
defaultFileName = fullfile(startingFolder, '*.jpg');
[baseFileName, folder] = uiputfile(defaultFileName, 'Specify a file');
if baseFileName == 0
	% User clicked the Cancel button.
	return;
end

fullFileName = fullfile(folder, baseFileName)
imwrite(img, fullFileName);
