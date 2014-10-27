function [added] =isCallTimein( aParentHistory,callTime,index)

handles.node.active{end}=index;
added=false;
parent=[];

callTimestr=num2str(callTime);
callTimeForSearch=callTimestr(~isspace(callTimestr));
aHistoryCall=num2str(aParentHistory.cfg.callinfo.calltime);
callTimeBeingSearched=aHistoryCall(~isspace(aHistoryCall));
if strcmp(callTimeForSearch,callTimeBeingSearched)
    added=true;
    aParentHistory.childList{end}=childHistoryFile; % burasý pass by reference olmalý
else
    for counter=1:length(aParentHistory.childList)
        aChild=aParentHistory.childList{counter};
        if ~isempty(aChild)
            [added]=isCallTimein(aChild,callTime);
        end
    end
end

end