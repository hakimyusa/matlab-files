function timestr = sec2timestr(sec)
% Convert a time measurement from seconds into a human readable string.
%
% Examples:
% 	sec2timestr(1)       => '1 sec'
% 	sec2timestr(11)      => '11 sec'
% 	sec2timestr(111)     => '1 min, 51 sec'
% 	sec2timestr(1111)    => '18 min'
% 	sec2timestr(11111)   => '3 hr, 5 min'
% 	sec2timestr(111111)  => '1 day, 6 hr'
% 	sec2timestr(1111111) => '12 day'
%
% Change log:
% 2004-Oct-08 - Steve Hoelzer - Conception
% 2004-Oct-20 - Steve Hoelzer - Efficient if-else structure
%

% Convert seconds to other units
d = floor(sec/86400); % Days
sec = sec - d*86400;
h = floor(sec/3600); % Hours
sec = sec - h*3600;
m = floor(sec/60); % Minutes
sec = sec - m*60;
s = floor(sec); % Seconds

% Create time string
if d > 0
    if d > 9
        timestr = sprintf('%d day',d);
    else
        timestr = sprintf('%d day, %d hr',d,h);
    end
elseif h > 0
    if h > 9
        timestr = sprintf('%d hr',h);
    else
        timestr = sprintf('%d hr, %d min',h,m);
    end
elseif m > 0
    if m > 9
        timestr = sprintf('%d min',m);
    else
        timestr = sprintf('%d min, %d sec',m,s);
    end
else
    timestr = sprintf('%d sec',s);
end
