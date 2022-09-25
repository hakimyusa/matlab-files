function [XX,BB,flag,MotVec,JO,JQ] = GetCurrentOperationHandleVariables(handles)
%%%The current Group of Pictures (GOP) starts from the i-th frame
%%%It is the j-th GOP
j=round(get(handles.GOPSlider,'value'));
i=(j-1)*9+1;

id = handles.identifier;
XX = handles.XX{j,id};
BB = handles.BB{j,id};
flag = handles.flag{j,id};
MotVec = handles.MotVec{j,id};
JO = handles.JO{j,id};
JQ = handles.JQ{j,id};

