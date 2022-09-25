function handles = SetCurrentOperationHandleVariables(handles,XX,BB,flag,MotVec,JO,JQ)
%%%The current Group of Pictures (GOP) starts from the i-th frame
%%%It is the j-th GOP
j=round(get(handles.GOPSlider,'value'));
i=(j-1)*9+1;

id = handles.identifier;
handles.XX{j,id} = XX;
handles.BB{j,id} = BB;
handles.flag{j,id} = flag;
handles.MotVec{j,id} = MotVec;
handles.JO{j,id} = JO;
handles.JQ{j,id} = JQ;

