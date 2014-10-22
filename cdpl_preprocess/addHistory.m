function [ historyTree] =addHistory ( aHistoryFile,historyTree)
    keyboard
    thereisParent=isfield(aHistoryFile.cfg,'previous');
    if(~thereisParent)
        [~,fileName,ext]=fileparts(aHistoryFile.cfg.dataset);
        historyTreeArray=[historyTree{:}];
        historyTreeFileNames={historyTreeArray.fileName};   
        index=find(strcmp(historyTreeFileNames,[fileName,ext]));
        historyTree{index}.childList{end}=aHistoryFile;
    else 
        parent=aHistoryFile.cfg.previous;
        [added,addedParent]=isAdded(parent.callinfo.calltime,historyTree);
        if(added)
            addedParent.childList{end}=aHistoryFile;
        else
            parent.childList{end}=aHistoryFile;
            historyTree=addHistory(parent,historyTree);
        end
        
    end
    
end
