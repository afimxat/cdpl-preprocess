function listBoxStrArray=cdpl_getListBoxStr(historyTree)
iterator=historyTree.depthfirstiterator;
depthTree=historyTree.depthtree;
listBoxStr='';
nodeIndexList=[];
for nodeIndex=iterator
    nodeHistory=historyTree.get(nodeIndex);
    try
        [~,funcName,~]=fileparts(nodeHistory.cfg.version.name);
        funcNameNode=funcName(4:end);
        depthNode=depthTree.get(nodeIndex);
        tireSeq='';
        for i=1:depthNode-1
            tireSeq=[tireSeq, '__'];
        end
        str=[tireSeq funcNameNode];
        listBoxStr=strvcat(listBoxStr,str);
        nodeIndexList=[nodeIndexList nodeIndex];
    catch
        if(nodeIndex>1)
            listBoxStr=strvcat(listBoxStr,nodeHistory);
            nodeIndexList=[nodeIndexList nodeIndex];
        end
    end
end

listBoxStrArray={listBoxStr,nodeIndexList};
end