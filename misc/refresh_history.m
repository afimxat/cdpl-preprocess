%%%Author:Toygan KILIÇ
%%%Date:05.10.2014
function [] = refresh_history( pathname ,hObject, handles,delete_ok)
new_datasets=dir([pathname,'\*.mat']);
[number_of_files,~]=size(new_datasets);
list_of_files=cell(number_of_files,1);

for counter=1:number_of_files
    list_of_files{counter,1}=new_datasets(counter).name;
end
new_listbox=strvcat(list_of_files);
if(delete_ok)
    set(handles.history,'Value',1)
end
delete_ok=0;
set(handles.history,'String',new_listbox)
if(get(handles.history,'Value')==0)
    set(handles.history,'Value',1)
end
guidata(hObject,handles)
end