function [ ] = refresh_listbox( pathname ,hObject, handles,delete_ok )
new_datasets=dir([pathname,'\*.eeg']);
[number_of_files,~]=size(new_datasets);
list_of_files=cell(number_of_files,1);

for counter=1:number_of_files
    list_of_files{counter,1}=new_datasets(counter).name;
end
new_listbox=strvcat(list_of_files);
if(delete_ok)
    set(handles.listbox1,'Value',get(handles.listbox1,'Value')-1)
end
delete_ok=0;
set(handles.listbox1,'String',new_listbox)
if(get(handles.listbox1,'Value')==0)
    set(handles.listbox1,'Value',1)
end
guidata(hObject,handles)
end

