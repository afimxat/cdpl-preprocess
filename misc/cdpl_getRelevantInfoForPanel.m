function panelStr=cdpl_getRelevantInfoForPanel(theNode)
panelStr='error loading';
try
    usercfg=theNode.cfg.callinfo.usercfg;
    fieldNames=fieldnames(usercfg);
    panelStr=fieldNames;
catch
end
% for i=1:length(fieldNames)
%     panelStr{i}= panelStr{i};
% end

end