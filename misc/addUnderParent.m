function [ added,historyTree] = addUnderParent( parentCallTime,historyTree, aChildHistoryFile )
%UNT�TLED2 Summary of this function goes here
%   Detailed explanation goes here
%historyTree �zerinde gez ve cfg nin alt�ndaki callinfonun alt�ndaki call
%timelara bak e�it bulursan addedParentta o cfg yi d�nd�r yoksa added false
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

