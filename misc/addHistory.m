function [ historyTree] =addHistory ( aChildHistoryNode,historyTree)
history=aChildHistoryNode.get(1);
thereisParent=isfield(history.cfg,'previous');
if(~thereisParent)
    [~,fileName,ext]=fileparts(history.cfg.dataset);
    eegFileNodes=historyTree.getchildren(1);
    for i=1:eegFileNodes
        thisNodeIndex=eegFileNodes(i);
        anEegFileName=historyTree.get(thisNodeIndex);
        if strcmp(anEegFileName,[fileName,ext])
            historyTree=historyTree.addnode(thisNodeIndex,history);
        end
    end
else
    parent=history.cfg.previous;
    nodeIndex=checkIfNodeIsInTree(parent,historyTree);
    if nodeIndex>1
        historyTree=historyTree.addnode(nodeIndex,history);
    else
        subTree=tree(parent);
        subTree=subTree.addnode(1,history);
        historyTree=addHistory(subTree,historyTree);
    end
    
end

end

