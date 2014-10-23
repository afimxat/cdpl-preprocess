function [added,historyTree] =isCallTimein( aHistory,callTime,historyTree, childHistoryFile)

added=false;
parent=[];

callTimestr=num2str(callTime);
callTimeForSearch=callTimestr(~isspace(callTimestr));
aHistoryCall=num2str(aHistory.cfg.callinfo.calltime);
callTimeBeingSearched=aHistoryCall(~isspace(aHistoryCall));
if strcmp(callTimeForSearch,callTimeBeingSearched)
    added=true;
    aHistory.childList{end}=childHistoryFile; % burasý pass by reference olmalý
else
    for counter=1:length(aHistory.childList)
        aChild=aHistory.childList{counter};
        if ~isempty(aChild)
            [added]=isCallTimein(aChild,callTime);
        end
    end
end

end