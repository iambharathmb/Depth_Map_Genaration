function varargout = stereoapp(varargin)
% STEREOAPP MATLAB code for stereoapp.fig
%      STEREOAPP, by itself, creates a new STEREOAPP or raises the existing
%      singleton*.
%
%      H = STEREOAPP returns the handle to a new STEREOAPP or the handle to
%      the existing singleton*.
%
%      STEREOAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEREOAPP.M with the given input arguments.
%
%      STEREOAPP('Property','Value',...) creates a new STEREOAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stereoapp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stereoapp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stereoapp

% Last Modified by GUIDE v2.5 09-Aug-2021 08:25:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stereoapp_OpeningFcn, ...
                   'gui_OutputFcn',  @stereoapp_OutputFcn, ...
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


% --- Executes just before stereoapp is made visible.
function stereoapp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stereoapp (see VARARGIN)

% Choose default command line output for stereoapp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stereoapp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stereoapp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in enterimagebtn.
function enterimagebtn_Callback(hObject, eventdata, handles)
% hObject    handle to enterimagebtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file1,path1]=uigetfile({'*.jpg';'*.png';'*.gif'},'FileSelector');
global origin_L_img;
origin_L_img=imread([path1,file1]);
figure;
imshow(origin_L_img);
[file2,path2]=uigetfile({'*.jpg';'*.png';'*.gif'},'FileSelector');
global origin_R_img;
origin_R_img=imread([path2,file2]);
figure;
imshow(origin_R_img);
global mod_img;
mod_img=imagestereo(origin_L_img,origin_R_img);


% --- Executes on button press in entervidbtn.
function entervidbtn_Callback(hObject, eventdata, handles)
% hObject    handle to entervidbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file1,path1]=uigetfile({'*.mp4';'*.avi'},'FileSelector');
Videostereo(path1,file1);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file1,path1]=uigetfile({'*.mp4';'*.avi'},'FileSelector');



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
[file3,path3]=uigetfile({'*.jpg';'*.png';'*.gif'},'FileSelector');
global mod_img;
imwrite(mod_img,[path3,file3]);



% --- Executes on button press in viewdepthbtn.
function viewdepthbtn_Callback(hObject, eventdata, handles)
% hObject    handle to viewdepthbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global origin_R_img;
global origin_L_img;
d=disparity(origin_L_img,origin_R_img);
marker_idx = (d == -10);
d(marker_idx) = min(d(~marker_idx));
figure; imshow(mat2gray(d));


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
global anaglyph;

writerObj = VideoWriter('myVideo.avi');
 writerObj.FrameRate = 16;
 % set the seconds per image
%  secsPerImage = [5 10 15];
 % open the video writer
 open(writerObj);
 % write the frames to the video
 for u=1:length(anaglyph)
     % convert the image to a frame
     frame = im2frame(anaglyph{u});
%      for v=1:secsPerImage(u) 
     writeVideo(writerObj, frame);
%      end
 end
