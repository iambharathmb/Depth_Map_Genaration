function varargout = button_enter_image(varargin)
% BUTTON_ENTER_IMAGE MATLAB code for button_enter_image.fig
%      BUTTON_ENTER_IMAGE, by itself, creates a new BUTTON_ENTER_IMAGE or raises the existing
%      singleton*.
%
%      H = BUTTON_ENTER_IMAGE returns the handle to a new BUTTON_ENTER_IMAGE or the handle to
%      the existing singleton*.
%
%      BUTTON_ENTER_IMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BUTTON_ENTER_IMAGE.M with the given input arguments.
%
%      BUTTON_ENTER_IMAGE('Property','Value',...) creates a new BUTTON_ENTER_IMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before button_enter_image_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to button_enter_image_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help button_enter_image

% Last Modified by GUIDE v2.5 05-Jun-2021 15:23:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @button_enter_image_OpeningFcn, ...
                   'gui_OutputFcn',  @button_enter_image_OutputFcn, ...
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


% --- Executes just before button_enter_image is made visible.
function button_enter_image_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to button_enter_image (see VARARGIN)

% Choose default command line output for button_enter_image
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(gcf,'WindowButtonDownFcn',{@mouse_down});
set(gcf,'WindowButtonMotionFcn',{@mouse_move});
set(gcf,'WindowButtonUpFcn',{@mouse_up});
set(gcf,'KeyPressFcn',@keyFcn);
global glb_handles;
global mouse_state;
global vid_or_img;
vid_or_img=0;
glb_handles = handles;
addpath('./Algorithms');
mouse_state = 0;



% UIWAIT makes button_enter_image wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = button_enter_image_OutputFcn(hObject, eventdata, handles) 
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
global img1;
global vid_or_img;
global selected_frames;
global vid;
if(vid_or_img ==1)
   img1=read(vid,selected_frames);
   imshow(img1,'Parent',handles.axes1);
else
    [file,path]=uigetfile('*.jpg');
    img1=imread([path,file]);
    imshow(img1,'Parent',handles.axes1);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Seg;
global Seeds;
global img1;
global im_show;
% if(sum(sum(Seeds==127))==0 || sum(sum(Seeds==255))==0)
%     disp('scribbles not provided!');
%     return;
% end
% graphcut = GMMGraphCutAlgorithm();
% Seg =graphcut.Segment(img1, Seeds);
disp(size(img1));
disp(size(Seeds));
%     graphcut = GMMGraphCutAlgorithm();
%     Seg =graphcut.Segment(Image, Seeds);
ui_update();
randomwalks(img1,im_show);
%figure;
%imshow(im_show);

% [filename, pathname] = uiputfile({'*.png';'*.jpg';'*.bmp'},'File Selector');
% imwrite(Seg*255,fullfile(pathname, filename));
% cla(handles.axes1,'reset');



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img1;
global Seeds;
global Seg;
[H, W, C] = size(img1);
Seeds = uint8(zeros([H,W]));
Seg = uint8(zeros([H, W]));
ui_update();




% --- Executes on button press in pushbutton_video.
function pushbutton_video_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
global numFrames;
global selected_frames;
[file2,path2]=uigetfile({'*.avi';'*.mp4'},'FileSelector');
vid=VideoReader([path2,file2]);
numFrames=vid.NumberOfFrames;
n=numFrames;
framestr=['Totalframes:',int2str(n)];

set(handles.text2,'String',framestr);

frame1=read(vid,1);
imshow(frame1,'parent',handles.axes2);
selected_frames=1;
% for i=1:2:n
%     frames=read(vid,i);
%     vid_frame(i)=image(frames);
% end
%     




% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
global selected_frames;
 specific_frame=get(handles.edit1,'String');
 specific_frame= str2num(specific_frame);
 disp(specific_frame);
 axes(handles.axes2);
 imshow(read(vid,specific_frame),'parent',handles.axes2);
 selected_frames=specific_frame;

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid_or_img;
vid_or_img=1;


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global depthselect0;
global depthselect1;
global depthselect2;
global depthselect3;
global depthselect4;
global depthselect5;
global depthselect6;
global depthselect7;
depthselect0=1;
depthselect1=0;
depthselect2=0;
depthselect3=0;
depthselect4=0;
depthselect5=0;
depthselect6=0;
depthselect7=0;


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global depthselect0;
global depthselect1;
global depthselect2;
global depthselect3;
global depthselect4;
global depthselect5;
global depthselect6;
global depthselect7;
depthselect0=0;
depthselect1=1;
depthselect2=0;
depthselect3=0;
depthselect4=0;
depthselect5=0;
depthselect6=0;
depthselect7=0;


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global depthselect0;
global depthselect1;
global depthselect2;
global depthselect3;
global depthselect4;
global depthselect5;
global depthselect6;
global depthselect7;
depthselect0=0;
depthselect1=0;
depthselect2=1;
depthselect3=0;
depthselect4=0;
depthselect5=0;
depthselect6=0;
depthselect7=0;


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global depthselect0;
global depthselect1;
global depthselect2;
global depthselect3;
global depthselect4;
global depthselect5;
global depthselect6;
global depthselect7;
depthselect0=0;
depthselect1=0;
depthselect2=0;
depthselect3=1;
depthselect4=0;
depthselect5=0;
depthselect6=0;
depthselect7=0;


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global depthselect0;
global depthselect1;
global depthselect2;
global depthselect3;
global depthselect4;
global depthselect5;
global depthselect6;
global depthselect7;
depthselect0=0;
depthselect1=0;
depthselect2=0;
depthselect3=0;
depthselect4=1;
depthselect5=0;
depthselect6=0;
depthselect7=0;


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global depthselect0;
global depthselect1;
global depthselect2;
global depthselect3;
global depthselect4;
global depthselect5;
global depthselect6;
global depthselect7;
depthselect0=0;
depthselect1=0;
depthselect2=0;
depthselect3=0;
depthselect4=0;
depthselect5=1;
depthselect6=0;
depthselect7=0;


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global depthselect0;
global depthselect1;
global depthselect2;
global depthselect3;
global depthselect4;
global depthselect5;
global depthselect6;
global depthselect7;
depthselect0=0;
depthselect1=0;
depthselect2=0;
depthselect3=0;
depthselect4=0;
depthselect5=0;
depthselect6=1;
depthselect7=0;


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global depthselect0;
global depthselect1;
global depthselect2;
global depthselect3;
global depthselect4;
global depthselect5;
global depthselect6;
global depthselect7;
depthselect0=0;
depthselect1=0;
depthselect2=0;
depthselect3=0;
depthselect4=0;
depthselect5=0;
depthselect6=0;
depthselect7=1;


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global numFrames;
global vid;
global selected_frames;
n=numFrames;
last_frame=read(vid,n);
imshow(last_frame,'parent',handles.axes2);
selected_frames=n;




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


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1,'reset');
global img1;
global Seeds;
global Seg;
[H, W, C] = size(img1);
Seeds = uint8(zeros([H,W]));
Seg = uint8(zeros([H, W]));
ui_update();
