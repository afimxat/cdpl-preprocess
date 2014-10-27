function [ added,historyTree] = addUnderParent( parentCallTime,historyTree, aChildHistoryFile )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here
%historyTree üzerinde gez ve cfg nin altýndaki callinfonun altýndaki call
%timelara bak eþit bulursan addedParentta o cfg yi döndür yoksa added false
%olacak.
added=false;
handles.node.active=[];
for i=1:length(historyTree)
    aRaw=historyTree{i};
    pathToNode=[];
    pathToNode{1}=i;
    for j=1:length(aRaw.childList)
        aChild=aRaw.childList{j};
        if ~isempty(aChild)
            [found,pathToNode]=isCallTimein(aChild,parentCallTime,pathToNode,j);
        end
    end
end
historyTree=addToNode(historyTree,pathToNode,aChildHistoryFile);

end

