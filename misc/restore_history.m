function [ output_args ] = restore_history( handles )
str_new='';
new_datasets=dir([handles.address_of_history,'\*.mat'])
general_list=get(handles.listbox1,'String')% this shows the list of the listbox then .
selected_file=get(handles.listbox1,'Value')% this is the selected file which will be processing.
file_name=general_list(selected_file,:);%file name address without path
file_name=strsplit(file_name,' ') % get rid of space in address
file_name=file_name{1} % space elimination
change_variable=file_name(1:length(file_name)-4)%get rid of ".eeg"

[number_of_files,~]=size(new_datasets)
list_of_files=cell(number_of_files,1)
    for counter=1:number_of_files
        list_of_files{counter,1}=new_datasets(counter).name;
    end
if(isempty(list_of_files))
    set(handles.history,'String',str_new);
    return
end
co_toy=1;
for counter2=1:length(list_of_files)
    comparable_str=list_of_files{counter2}(1:length(change_variable));
    if(strcmp(change_variable,comparable_str))
        str_new{co_toy}=list_of_files{counter2};
        co_toy=co_toy+1;
    end
end
set(handles.history,'String',strvcat(str_new));
if (get(handles.listbox1,'Value')==number_of_files)
    set(handles.listbox1,'Value',number_of_files)
end
%pro_file_address=[handles.address_of_history,'\',file_name];%concenation of file and current folder

end

