%%%Checks whether a cell called cellname
%%%exists in the structure handles,
%%%and furthermore wheather handles.cellname{index} exists
function calc = checkAllReadyCalculated(handles,cellName,index)
calc=true;
if (~isfield(handles,cellName)) 
    calc=false;
    return;
end


s=getfield(handles,cellName);
if (numel(s)==0)
    calc=false;
    return;
end
    
    
if (size(s,2)<index)
    calc=false;
    return;
end
    
if (numel(s{index})==0) 
    calc=false;
    return;
end
