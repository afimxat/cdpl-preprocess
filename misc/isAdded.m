function [ added,historyTree] = isAdded( callTime,historyTree, aChildHistoryFile )
%UNT�TLED2 Summary of this function goes here
%   Detailed explanation goes here
%historyTree �zerinde gez ve cfg nin alt�ndaki callinfonun alt�ndaki call
%timelara bak e�it bulursan addedParentta o cfg yi d�nd�r yoksa added false
%olacak.
added=false;
for i=1:length(historyTree)
    aHistory=historyTree{i};
    for j=1:length(aHistory.childList)
        aChild=aHistory.childList{j};
        if ~isempty(aChild)
            [added,historyTree]=isCallTimein(aChild,callTime,historyTree,aChildHistoryFile);
        end
    end
end

end

