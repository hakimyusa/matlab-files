%istft.m
function x = istft(d, ftsize, w, h)
s = size(d);
cols = s(2);
xlen = ftsize + (cols-1)*h;
x = zeros(1,xlen);
if length(w) == 1
if w == 0
win = ones(1,ftsize);
else
if rem(w, 2) == 0
w = w + 1;
end
halflen = (w-1)/2;
halff = ftsize/2;
halfwin = 0.5 * ( 1 + cos( pi * (0:halflen)/halflen));
win = zeros(1, ftsize);
acthalflen = min(halff, halflen);
win((halff+1):(halff+acthalflen)) = halfwin(1:acthalflen);

win((halff+1):-1:(halff-acthalflen+2)) = halfwin(1:acthalflen);

win = 2/3*win;
end
else
win = w;
w = length(win);
end

for b = 0:h:(h*(cols-1))
ft = d(:,1+b/h)';
ft = [ft, conj(ft([((ftsize/2)):-1:2]))];
px = real(ifft(ft));
x((b+1):(b+ftsize)) = x((b+1):(b+ftsize))+px.*win;
end;