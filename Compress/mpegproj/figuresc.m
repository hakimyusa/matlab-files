function varargout = figuresc(sf)
% figuresc(sf) creates a normal figure except that figure size is controlled by
% the scaling factor, sf. The scaling factor is relative to screen size so 1.0
% makes the figure fill the entire screen. Note that the display portion of the
% window will be the same size as the screen. The window border will be outside
% of that so sf = 1.0 usually doesn't look good. Smaller scale factors adjust
% height and width proportionally and center the figure.
%
% The scaling factor can be a single value (sf = 0.8) to scale width and height
% identically or two values (sf = [0.8, 0.6]) to scale width and height
% seperately. The scaling factor(s) must be between 0.0 and 1.0.
%
% Demo code (and fun too!):
%      for sf = 0.9:-0.1:0.1, figuresc(sf), end
%
% Steve Hoelzer
% 2004-Sep-02 - Created
% 2004-Sep-03 - Option to scale width and height independently
% 2004-Oct-22 - Pass out figure handle if requested
% 2005-Mar-16 - Don't show figure handle on command line

% Error checking
if any(sf < 0.0) | any(sf > 1)
    error('Scaling factor must be between 0.0 and 1.0')
end

% Scale width and height identically if sf has a single element
if numel(sf) == 1
    sf = [sf sf];
end

% Calculate [left, bottom, width, height]
pos = [(1-sf)/2, sf];

% Display figure
f = figure('Units','Normalized', ...
    'Position',pos(:)); % pos is always a vector

if nargout > 0
    varargout{1} = f;
end
