function varargout = brain_eeg_analysis(varargin)
% BRAIN_EEG_ANALYSIS MATLAB code for brain_eeg_analysis.fig
%      BRAIN_EEG_ANALYSIS, by itself, creates a new BRAIN_EEG_ANALYSIS or raises the existing
%      singleton*.
%
%      H = BRAIN_EEG_ANALYSIS returns the handle to a new BRAIN_EEG_ANALYSIS or the handle to
%      the existing singleton*.
%
%      BRAIN_EEG_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRAIN_EEG_ANALYSIS.M with the given input arguments.
%
%      BRAIN_EEG_ANALYSIS('Property','Value',...) creates a new BRAIN_EEG_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before brain_eeg_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to brain_eeg_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help brain_eeg_analysis

% Last Modified by GUIDE v2.5 20-Oct-2014 17:57:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @brain_eeg_analysis_OpeningFcn, ...
    'gui_OutputFcn',  @brain_eeg_analysis_OutputFcn, ...
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

% --- Executes just before brain_eeg_analysis is made visible.
function brain_eeg_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to brain_eeg_analysis (see VARARGIN)

% Choose default command line output for brain_eeg_analysis
handles.output = hObject;
handles.address_of_files='';
[~,hostName]=system('hostname');
if strcmp(strtrim(hostName),'umram-utku-PC')
    handles.address_of_history='C:\Users\umram-utku\Documents\MATLAB\cdpl_preprocess\history';
    handles.address_of_raw='C:\Users\umram-utku\Documents\MATLAB\cdpl_preprocess\raw';
    handles.address.github='C:\Users\umram-utku\Documents\GitHub\cdpl-preprocess\';
else
    handles.address_of_history='C:\Users\Toygan\Desktop\fieldtrip\data_values\history';
    handles.address_of_raw='C:\Users\Toygan\Desktop\fieldtrip\data_values\raw';
    handles.address.github='C:\Users\Toygan\Documents\GitHub\cdpl-preprocess\';
end
cd(handles.address.github);
addpath(handles.address.github,[handles.address.github,'misc\'],genpath([handles.address.github,'lib\']));

%
% Update handles structure
%warning('off','MATLAB:namelengthmaxexceeded')
guidata(hObject, handles)

% UIWAIT makes brain_eeg_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);
handles.address_of_history
handles.address_of_files

% --- Outputs from this function are returned to the command line.
function varargout = brain_eeg_analysis_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on selection change in step_list_listbox.
function step_list_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to step_list_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns step_list_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_list_listbox
listIndex=get(hObject,'Value')
historyTree=handles.historyTree;
nodeIndexes=handles.listBoxNodeIndexes;
theNode=historyTree.get(nodeIndexes(listIndex));
panelStr=cdpl_getRelevantInfoForPanel(theNode);
panelStr=strvcat(panelStr);
set(handles.property_text,'String',panelStr);
guidata(hObject,handles);
% restore_history(handles)

% --- Executes during object creation, after setting all properties.
function step_list_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_list_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in segmentation_pushbutton.
function segmentation_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to segmentation_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete_ok=0; %% determine whether this operation is a deleting or not
first_control = get(handles.first_box,'Value');
second_control = get(handles.second_button,'Value');
controller =[first_control second_control];
answers = inputdlg({'Prestimulus Time',...
    'Post Stimulus Time',...
    'Event Type',...
    'Event Value'},...
    'Continuos to Trial',[1 1 1 1],...
    {'0.4','0.8','Stimulus','S  1'});

[change_variable,pro_file_address]=ch_name(handles,controller); %find the location and prepare new structure
pre_or_sample=change_variable(length(change_variable)-1:length(change_variable));
change_variable=[change_variable,'_t']; %add _t


data=open(pro_file_address);
data=getfield(data,change_variable(1:length(change_variable)-2));

%%%FIELDTRIP OPERATIONS
cfg=[];
if(~strcmp(pre_or_sample,'_p'))
    cfg.dataset=data.cfg.previous.dataset;% determining the address of dataset
else
    cfg.dataset=data.cfg.dataset;
end

cfg.trialdef.prestim=str2num(answers{1});
cfg.trialdef.poststim=str2num(answers{2});
cfg.trialdef.eventtype=answers{3};
cfg.trialdef.eventvalue= {answers(4)}; %% If you have 1 digit put 2 space ex. 'S  1' for 2 digit 'S 11' and 'S111'
cfg_all_trials=ft_definetrial(cfg);
trl=cfg_all_trials.trl;

cfg=[];
cfg.trl=trl;
new_dataset=ft_redefinetrial(cfg,data);% preprocessing
%%%saving the processing data
cd(handles.address_of_history);% put current datapath to history
S.(change_variable)=new_dataset; % name new variable according to change_variable
save(change_variable,'-struct','S')
cd(handles.address_of_files)
%%%history listbox refreshing
pathname = handles.address_of_history;
refresh_history(pathname,hObject,handles,delete_ok)

% --- Executes on button press in ocular_pushbutton.
function ocular_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ocular_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('I,m not ready yet:(','My Help Message','help');
global toy
toy=toy+1;

% --- Executes on button press in visual_artifact_pushbutton.
function visual_artifact_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to visual_artifact_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('I,m not ready yet:(','My Help Message','help');

% --- Executes on button press in problem.
function problem_Callback(hObject, eventdata, handles)
% hObject    handle to problem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
minus_and_plus=char(177);
msgbox({['1. Analyzer Export'] ,...
    '2. Tree',...
    '11. Add a field which shows the properties of the selected file'},'PROBLEMS','help');


% --- Executes on button press in filtering_pushbutton.
function filtering_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to filtering_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('I,m not ready yet:(','My Help Message','help');

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over resample_pushbutton.
function resample_pushbutton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to resample_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in browse_pushbutton.
function browse_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to browse_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
histLoc=handles.address_of_history;
rawLoc=handles.address_of_raw;
[pathname] = uigetdir(rawLoc,'EEG Path Browser');
set(handles.home_folder_text,'String',pathname)
rawFilePaths=dir([pathname,'\*.eeg']);

listOfRawFiles={rawFilePaths.name};
disp(listOfRawFiles);
historyTree=tree();
for i=1:length(listOfRawFiles)
    [historyTree]=historyTree.addnode(1,listOfRawFiles{i});
end
historyFilePaths=dir([histLoc,'\*.mat']);
listOfHistoryFiles={historyFilePaths.name};
historyFiles=cell(length(listOfHistoryFiles),1);
for counter=1:length(historyFiles)
    aCFG=open([histLoc,filesep,listOfHistoryFiles{counter}]);
    aHistoryFile=aCFG.(char(fieldnames(aCFG)));
    historyFiles{counter}=aHistoryFile;
end
for counter=1:length(historyFiles)
    aHistory=historyFiles{counter};
    childHistoryNode=tree(aHistory);
    historyTree=addHistory(childHistoryNode,historyTree);
end
listBoxStrArray=cdpl_getListBoxStr(historyTree);
listBoxStr=listBoxStrArray{1};
listBoxNodeIndexes=listBoxStrArray{2};

% %%%CONTROL FOR LAST SELECTION
% if((get(handles.step_list_listbox,'Value')==0)||(get(handles.step_list_listbox,'Value')>1))
%     set(handles.step_list_listbox,'Value',1);
% end
set(handles.step_list_listbox,'String',listBoxStr)
handles.listBoxNodeIndexes=listBoxNodeIndexes;
handles.address_of_files=pathname;
handles.historyTree=historyTree;
guidata(hObject,handles)


% --- Executes on button press in exit_pushbutton.
function exit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to exit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exit_button=questdlg('Exit Now?','Exit Program','Yes','No','No');

switch exit_button
    case 'Yes'
        delete(handles.figure1)
    case 'No'
        return
end


% --- Executes on button press in refresh_pushbutton.
function refresh_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to refresh_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
history_refresh=handles.address_of_history;
listbox_refresh=handles.address_of_files;
refresh_history(history_refresh,hObject,handles,0);
refresh_listbox(listbox_refresh,hObject,handles,0);


% --- Executes on button press in delete_pushbutton.
function delete_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to delete_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete_ok=1;
index=get(handles.history,'Value'); % get the values from history listbox
list=get(handles.history,'String');
for counter=1:length(index)
    deleted_file=strsplit(list(index(counter),:));
    deleted_file=deleted_file{1};
    deleted_file=[handles.address_of_history,'\',deleted_file];
    delete(deleted_file)
end
refresh_history(handles.address_of_history,hObject,handles,delete_ok)
% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function delete_pushbutton_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to delete_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in play_music_pushbutton.
function play_music_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to play_music_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('C:\Users\Toygan\Desktop\fieldtrip\data_values\experiment_01\test\music.mat')
sound(data,fs)
keyboard


% --- Executes on button press in preprocess_pushbutton.
function preprocess_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to preprocess_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to history (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns history contents as cell array
%        contents{get(hObject,'Value')} returns selected item from history
% hObject    handle to resample_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete_ok=0; %% determine whether this operation is a deleting or not
first_control = get(handles.first_box,'Value');
second_control = get(handles.second_button,'Value');
controller =[first_control second_control];
if(~first_control&&~second_control)
    msgbox('You should turn the "<" box on','Warning')
    return
end
answers = inputdlg({'Low Pass Filter',...
    'High Pass Filter',...
    'Notch Filter(not working yet)',},...
    'Window Name',[1 1 1],...
    {'','',''});

[change_variable,pro_file_address]=ch_name(handles,controller); %find the location and prepare new structure
change_variable=[change_variable,'_p']; %add _c
%%%FIELDTRIP OPERATIONS
cfg=[];
cfg.dataset=pro_file_address;% determining the address of dataset
cfg.lpfilter ='yes';
cfg.hpfilter ='yes';
cfg.lpfreq   =str2num(answers{1});
cfg.hpfreq   =str2num(answers{2});
new_dataset=ft_preprocessing(cfg);% preprocessing
%%%saving the processing data
cd(handles.address_of_history);% put current datapath to history
S.(change_variable)=new_dataset; % name new variable according to change_variable
save(change_variable,'-struct','S')
cd(handles.address_of_files)
%%%history listbox refreshing
pathname = handles.address_of_history;
refresh_history(pathname,hObject,handles,delete_ok)



% --- Executes on button press in resample_pushbutton.
function resample_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to resample_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete_ok =0; %% determine whether this operation is a deleting or not
first_control = get(handles.first_box,'Value');
second_control = get(handles.second_button,'Value');
controller =[first_control second_control];
if((controller(1,1)==1)&&(controller(1,2)==0))
    msgbox('You should turn history box for "Change Sample" operation. You have to do "Preprocessing" before this operation','Warning')
    return
end
answers = inputdlg({'New Sampling Frequency'},'Window Name',1, {''});
[change_variable,pro_file_address]=ch_name(handles, controller); %find the location and prepare new structure
change_variable=[change_variable,'_c']; %add _c
data=open(pro_file_address);
data=getfield(data,[change_variable(1:length(change_variable)-2)]);
%% FIELDTRIP OPERATIONS
%%  RESAMPLING DATA
% resampling data
cfg = [];
cfg.resamplefs = str2num(answers{1});
cfg.detrend    = 'no';
new_dataset = ft_resampledata(cfg, data);
%%%saving the processing data
cd(handles.address_of_history);% put current datapath to history
S.(change_variable)=new_dataset; % name new variable according to change_variable
save(change_variable,'-struct','S')
cd(handles.address_of_files)
%%%history listbox refreshing
pathname = handles.address_of_history;
refresh_history(pathname,hObject,handles,delete_ok)

% --- Executes on button press in plot_eeg_pushbutton.
function plot_eeg_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plot_eeg_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in import_pushbutton.
function import_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to import_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
