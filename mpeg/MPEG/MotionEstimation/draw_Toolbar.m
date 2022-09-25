function draw_Toolbar(hObject,handles)


set(hObject,'Toolbar','figure');
tbhi = findall(hObject,'Type','uitoolbar');
tbh = findall(tbhi,'Parent',tbhi);


marker = 0;

for i=1:length(tbh)
    
    temp = get(tbh(i),'Tag');
    
    set(tbh(i),'Separator','off');

    if strcmp(temp,'Standard.FileOpen')
        marker = marker + 1;    
        default_toggle_buttons(marker) = tbh(i);
        set(tbh(i),'ClickedCallback','MPEG(''OpenFile_Callback'',gcbo,[],guidata(gcbo))');
    elseif  strcmp(temp,'Standard.PrintFigure')
        marker = marker + 1;    
        default_toggle_buttons(marker) = tbh(i);
    elseif strcmp(temp,'Exploration.ZoomIn') || strcmp(temp,'Exploration.ZoomOut')
        marker = marker + 1;    
        default_toggle_buttons(marker) = tbh(i);
    else
        set(tbh(i),'Visible','off');
    end
    
end


icon =imread('icons/MotEst.jpg');

uipushtool(tbhi,'CData',icon,...
    'Separator','on','HandleVisibility','on','TooltipString','Block Matching ME',...
    'ClickedCallback','MPEG(''BlockMatchingBtn_Callback'',gcbo,[],guidata(gcbo))');

icon =imread('AboutLOGOS/VLabsSmall.png');
uipushtool(tbhi,'CData',icon,...
    'Separator','on','HandleVisibility','on','TooltipString','About...',...
    'ClickedCallback','AboutVLABS');
