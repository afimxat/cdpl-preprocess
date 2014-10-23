function [ added,addedParent ] = isAdded( callTime,historyTree )
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here
%historyTree üzerinde gez ve cfg nin altýndaki callinfonun altýndaki call
%timelara bak eþit bulursan addedParentta o cfg yi döndür yoksa added false
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

