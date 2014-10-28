function str=cdpl_getUniqStr(node)
str=num2str(node.cfg.callinfo.calltime);
str=str(~(str==' '));

end