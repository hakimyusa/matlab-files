arargout = proses_encoding(varargin)
% PROSES_ENCODING MATLAB code for proses_encoding.fig
%      PROSES_ENCODING, by itself, creates a new PROSES_ENCODING or raises the existing
%      singleton*.
%
%      H = PROSES_ENCODING returns the handle to a new PROSES_ENCODING or the handle to
%      the existing singleton*.
%
%      PROSES_ENCODING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROSES_ENCODING.M with the given input arguments.
%
%      PROSES_ENCODING('Property','Value',...) creates a new PROSES_ENCODING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proses_encoding_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proses_encoding_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
 
% Edit the above text to modify the response to help proses_encoding
 
% Last Modified by GUIDE v2.5 28-Sep-2021 18:06:18
 
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @proses_encoding_OpeningFcn, ...
    'gui_OutputFcn',  @proses_encoding_OutputFcn, ...
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
 
 
% --- Executes just before proses_encoding is made visible.
function proses_encoding_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proses_encoding (see VARARGIN)
 
% Choose default command line output for proses_encoding
handles.output = hObject;
 
% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');
 
% UIWAIT makes proses_encoding wait for user response (see UIRESUME)
% uiwait(handles.figure1);
 
 
% --- Outputs from this function are returned to the command line.
function varargout = proses_encoding_OutputFcn(hObject, eventdata, handles)
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
 
% menampilkan menu open file
[nama_file, nama_path] = uigetfile('*.bmp');
% jika ada file yang dipilih maka akan mengeksekusi perintah di bawahnya
if ~isequal(nama_file,0)
    % membaca file citra
    Img_cover = imread(fullfile(nama_path,nama_file));
    % menampilkan citra pada axes1
    axes(handles.axes1)
    imshow(Img_cover)
    title('Citra Cover')
    % menyimpan variabel Img_cover pada lokasi handles
    handles.Img_cover = Img_cover;
    guidata(hObject, handles)
else
    % jika tidak ada file yang dipilih maka akan kembali
    return
end
 
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% menampilkan menu open file
[nama_file, nama_path] = uigetfile('*.bmp');
% jika ada file yang dipilih maka akan mengeksekusi perintah di bawahnya
if ~isequal(nama_file,0)
    % membaca file citra
    Img_message = imread(fullfile(nama_path,nama_file));
    % menampilkan citra pada axes2
    axes(handles.axes2)
    imshow(Img_message)
    title('Citra Message')
    % menyimpan variabel Img_message pada lokasi handles
    handles.Img_message = Img_message;
    guidata(hObject, handles)
else
    % jika tidak ada file yang dipilih maka akan kembali
    return
end
 
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% memanggil variabel Img_cover dan Img_message yang ada di lokasi handles
Img_cover = handles.Img_cover;
Img_message = handles.Img_message;
 
% jika kedua citra berukuran sama maka akan mengeksekusi perintah di
% bawahnya
if isequal(size(Img_cover),size(Img_message))
    % membaca LSB bits yang ada di edit1
    n = str2double(get(handles.edit1,'String'));
    % proses steganografi dengan metode substitusi LSB
    Img_steg = uint8(bitor(bitand(Img_cover,bitcmp(2^n-1,'uint8')),...
        bitshift(Img_message,n-8)));
    % menampilkan citra hasil steganografi pada axes3
    axes(handles.axes3)
    imshow(Img_steg)
    title('Citra Steganografi')
    % menyimpan citra hasil steganografi pada lokasi handles
    handles.Img_steg = Img_steg;
    guidata(hObject, handles)
else
    % jika kedua citra berukuran tidak sama maka akan menampilkan
    % error dialog
    errordlg('Ukuran kedua citra harus sama','File Error');
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
 
 
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% membaca citra hasil steganografi yang ada di lokasi handles
Img_steg = handles.Img_steg;
% menampilkan menu save file
[nama_file, nama_path] = uiputfile('*.bmp');
% jika ada file yang dipilih maka akan mengeksekusi perintah di bawahnya
if ~isequal(nama_file,0)
    % menyimpan citra hasil steganografi
    imwrite(Img_steg,fullfile(nama_path,nama_file))
else
    % jika ada file yang dipilih maka akan kembali
    return
end
 
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% mereset button2
axes(handles.axes1)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
 
axes(handles.axes2)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
 
axes(handles.axes3)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
 
set(handles.edit1,'String','1')
