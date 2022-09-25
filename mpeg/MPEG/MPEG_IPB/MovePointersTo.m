%%%Moves the three pointers (blue, green, red) of the GUI
%%%above three wanted axes, from the totally 20 axes of the GUI
%%%AxesIndexes: A 1x3 vector, with elements in [1, 10]
%%%The first pointer is moved to one of the top axes
%%%The second or third pointer is moved to one of the bottom axes
%%%If an element of the vector AxesIndexes is zero, the corresponding
%%%pointer becomes invisible
function MovePointersTo(handles,AxesIndexes)

ax{1} = handles.I1Axes;
ax{2} = handles.B2Axes;
ax{3} = handles.B3Axes;
ax{4} = handles.P4Axes;
ax{5} = handles.B5Axes;
ax{6} = handles.B6Axes;
ax{7} = handles.P7Axes;
ax{8} = handles.B8Axes;
ax{9} = handles.B9Axes;
ax{10} = handles.I10Axes;
ax{11} = handles.I1dAxes;
ax{12} = handles.B2dAxes;
ax{13} = handles.B3dAxes;
ax{14} = handles.P4dAxes;
ax{15} = handles.B5dAxes;
ax{16} = handles.B6dAxes;
ax{17} = handles.P7dAxes;
ax{18} = handles.B8dAxes;
ax{19} = handles.B9dAxes;
ax{20} = handles.I10dAxes;

set(handles.ShowInOrigBtn,'visible','on');
set(handles.ShowInDecoded1Btn,'visible','on');
set(handles.ShowInDecoded2Btn,'visible','on');

if (AxesIndexes(1)==0)
    set(handles.ShowInOrigBtn,'visible','off');
else
    pos = get(ax{AxesIndexes(1)},'position');
    X = pos(1)+pos(3)/2-2; Y=pos(2)-0.5;
    set(handles.ShowInOrigBtn,'position',[X Y 3 1.5]);
end

if (AxesIndexes(2)==0)
    set(handles.ShowInDecoded1Btn,'visible','off');
else
    pos = get(ax{AxesIndexes(2)+10},'position');
    X = pos(1)+pos(3)/2-2; Y=pos(2)-0.5;
    set(handles.ShowInDecoded1Btn,'position',[X Y 3 1.5]);
end


if (AxesIndexes(3)==0)
    set(handles.ShowInDecoded2Btn,'visible','off');
else
    pos = get(ax{AxesIndexes(3)+10},'position');
    X = pos(1)+pos(3)/2-2; Y=pos(2)-0.5;
    set(handles.ShowInDecoded2Btn,'position',[X Y 3 1.5]);
end
    
