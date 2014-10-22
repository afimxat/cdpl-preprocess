function [ change_variable,pro_file_address ] = ch_name( handles ,controller)
if((controller(1,1)==1)&&(controller(1,2)==0))
    selected_box='listbox1';
else
    selected_box='history';
end
switch selected_box
    case 'listbox1'
        h=handles.listbox1;
        current_folder=handles.address_of_files;
    case 'history'
        h=handles.history;
        current_folder=handles.address_of_history;
end
general_list=get(h,'String');% this shows the list of the listbox then .
selected_file=get(h,'Value');% this is the selected file which will be processing.
file_name=general_list(selected_file,:);%file name address without path
file_name=strsplit(file_name,' '); % get rid of space in address
file_name=file_name{1}; % space elimination
pro_file_address=[current_folder,filesep,file_name];%concenation of file and current folder
[~,change_variable,~]=fileparts(file_name);%get rid of ".eeg"
end

