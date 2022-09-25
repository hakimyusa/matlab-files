function OperationOnTheFly(start,handles)


if (start==true)
    set(handles.StatusText,'String','Status: Please wait ...');
    set(handles.GOPSlider,'enable','inactive');
    set(handles.operationSlider,'enable','inactive');
else
    set(handles.StatusText,'String','Status: Ready!');
    set(handles.GOPSlider,'enable','on');
    set(handles.operationSlider,'enable','on');
end

drawnow;

guidata(handles.StatusText, handles);