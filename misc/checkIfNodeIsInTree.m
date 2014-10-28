function nodeIndex=checkIfNodeIsInTree(theNode,historyTree)
keyboard
iterator=historyTree.depthfirstiterator;
found=0;
for nodeIndex=iterator
    node=historyTree.get(nodeIndex);
    %     uStr=cdpl_getUniqStr(node);
    %     theStr=cdpl_getUniqStr(theNode);
    %     if strcmp(uStr,theStr)
    try
        if isequal(node.cfg.callinfo.calltime,theNode.callinfo.calltime)
            found=1;
            break;
        end
    catch
    end
    
end
if ~found
    nodeIndex=0;
end

end