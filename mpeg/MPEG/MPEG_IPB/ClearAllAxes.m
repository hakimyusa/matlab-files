function handles = ClearAllAxes(handles)

MovePointersTo(handles,[0 0 0]);

%%%Clear all axes
axes(handles.I1Axes); cla; title('');
axes(handles.B2Axes); cla; title('');
axes(handles.B3Axes); cla; title('');
axes(handles.P4Axes); cla; title('');
axes(handles.B5Axes); cla; title('');
axes(handles.B6Axes); cla; title('');
axes(handles.P7Axes); cla; title('');
axes(handles.B8Axes); cla; title('');
axes(handles.B9Axes); cla; title('');
axes(handles.I10Axes); cla; title('');

axes(handles.I1dAxes); cla; title('');
axes(handles.B2dAxes); cla; title('');
axes(handles.B3dAxes); cla; title('');
axes(handles.P4dAxes); cla; title('');
axes(handles.B5dAxes); cla; title('');
axes(handles.B6dAxes); cla; title('');
axes(handles.P7dAxes); cla; title('');
axes(handles.B8dAxes); cla; title('');
axes(handles.B9dAxes); cla; title('');
axes(handles.I10dAxes); cla; title('');

drawnow;

        