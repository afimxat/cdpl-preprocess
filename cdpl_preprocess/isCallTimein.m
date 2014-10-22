function [added, parent] =isCallTimein( aHistory,callTime)
disp('isCallTimein');
keyboard

added=false;
parent=[];
callTimeForSearch=callTime(~isspace(callTime));
aHistoryCall=num2str(aHistory.cfg.callinfo.calltime);
callTimeBeingSearched=aHistoryCall(~isspace(aHistoryCall));
if strcmp(callTimeForSearch,callTimeBeingSearched)
    added=true;
    parent=aHistory;
else
    for counter=1:length(aHistory.childList)
        aChild=aHistory.childList{counter};
        if ~isempty(aChild)
            [added, parent]=isCallTimein(aChild,callTime);
        end
    end
end

end