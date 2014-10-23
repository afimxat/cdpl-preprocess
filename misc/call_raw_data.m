function [raw_data] = call_raw_data(address_dir,address_file_name)
%% defining EEG 
    clear subjectdata
% define the filenames, parameters and other information that is subject specific
    subjectdata.dataset           = fullfile(address_dir,address_file_name);
    raw_data=subjectdata.dataset;

end

