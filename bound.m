function [y] = bound(x)
%+++++++++++++++++++++++++++++++++++++++++++++++++++
%fungsi : membatasi nilai dari pixel rgb
%+++++++++++++++++++++++++++++++++++++++++++++++++++
if x > 255 
y = 255;
elseif x < 0 
y = 0;
else
y = x;
end;
