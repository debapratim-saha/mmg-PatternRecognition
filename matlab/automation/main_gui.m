function varargout = main_gui(varargin)
% MAIN_GUI MATLAB code for main_gui.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_gui

% Last Modified by GUIDE v2.5 27-Jan-2014 17:35:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @main_gui_OutputFcn, ...
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


% --- Executes just before main_gui is made visible.
function main_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_gui (see VARARGIN)

    % Choose default command line output for main_gui
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % Put GUI into 'live' mode
    enable_live_mode(hObject, handles);

    % UIWAIT makes main_gui wait for user response (see UIRESUME)
    % uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;


% --- Executes on button press in start_audio_button.
function start_audio_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_audio_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    setappdata(0, 'IsProcessingAudio', 1);    
    if strcmp(handles.InputMode, 'File')
        [good_frames] = process_input(handles.SelectedFilePath);
    else
        [good_frames] = process_input;
    end
    setappdata(0, 'IsProcessingAudio', 0);
    fprintf('found %d good frame(s)\n', good_frames);


% --- Executes on button press in stop_audio_button.
function stop_audio_button_Callback(hObject, eventdata, handles)
% hObject    handle to stop_audio_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    setappdata(0, 'IsProcessingAudio', 0);


% --- Executes on button press in choose_file_button.
function choose_file_button_Callback(hObject, eventdata, handles)
% hObject    handle to choose_file_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [FileName, PathName, FilterIndex] = uigetfile;
    handles.SelectedFilePath = strcat(PathName, FileName);
    set(handles.selected_file_label, 'String', FileName);
    guidata(hObject, handles);


% --- Executes when selected object is changed in mode_button_group.
function mode_button_group_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in mode_button_group 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

    % Get tag of selected option
    switch get(eventdata.NewValue, 'Tag')
        case 'mode_live_button'
            enable_live_mode(hObject, handles);
        case 'mode_file_button'
            enable_file_mode(hObject, handles);
    end

function enable_file_mode(hObject, handles)
    set(handles.choose_file_button, 'Enable', 'on');
    set(handles.selected_file_label, 'Enable', 'on');
    handles.InputMode = 'File';
    guidata(hObject, handles);


function enable_live_mode(hObject, handles)
    set(handles.choose_file_button, 'Enable', 'off');
    set(handles.selected_file_label, 'Enable', 'off');
    handles.InputMode = 'Live';
    guidata(hObject, handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Hint: delete(hObject) closes the figure
    setappdata(0, 'IsProcessingAudio', 0);
    delete(hObject);
