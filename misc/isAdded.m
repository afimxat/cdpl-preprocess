function [ added,addedParent ] = isAdded( callTime,historyTree )
%UNT�TLED2 Summary of this function goes here
%   Detailed explanation goes here
%historyTree �zerinde gez ve cfg nin alt�ndaki callinfonun alt�ndaki call
%timelara bak e�it bulursan addedParentta o cfg yi d�nd�r yoksa added false
%olacak.
disp('isAdded');
keyboard
added=false;
addedParent=[];
for counter=1:length(historyTree)
    aHistory=historyTree{counter};
    for counter=1:length(aHistory.childList)
        aChild=aHistory.childList{counter};
        if ~isempty(aChild)
            [added, parent]=isCallTimein(aChild,callTime);
        end
    end
end

end

