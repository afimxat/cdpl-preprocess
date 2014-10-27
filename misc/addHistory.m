function [ historyTree] =addHistory ( aChildHistoryFile,historyTree)
keyboard
thereisParent=isfield(aChildHistoryFile.cfg,'previous');
if(~thereisParent)
    [~,fileName,ext]=fileparts(aChildHistoryFile.cfg.dataset);
    historyTreeArray=[historyTree{:}];
    historyTreeFileNames={historyTreeArray.fileName};
    index=strcmp(historyTreeFileNames,[fileName,ext]);
    historyTree{index}.childList{end}=aChildHistoryFile;
else
    parent=aChildHistoryFile.cfg.previous;
    [added,historyTree]=addUnderParent(parent.callinfo.calltime,historyTree,aChildHistoryFile);
    if(added)
    else
        parent.childList{end}=aChildHistoryFile;
        historyTree=addHistory(parent,historyTree);
    end
    
end

end

