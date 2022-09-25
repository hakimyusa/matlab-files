% function stft.m
function D = stft(x, f, w, h, sr)
if nargin < 2; f = 512; end
if nargin < 3; w = f; end
if nargin < 4; h = 512/4; end
if nargin < 5; sr = 8000; end

if size(x,1) > 1
x = x';
    end
s = length(x);
if length(w) == 1
    if w == 0
        win = ones(1,f);
    else
        if rem(w, 2) == 0
            w = w + 1;
        end
        halflen = (w-1)/2;
        halff = f/2;
        halfwin = 0.5 * ( 1 + cos( pi * 0:halflen)/halflen);
        win = zeros(1, f);
        acthalflen = min(halff, halflen);
        win((halff+1):(halff+acthalflen)) = halfwin(1:acthalflen);
        win((halff+1):-1:(halff-acthalflen+2)) = halfwin(1:acthalflen); 
    end
else
    win = w;
end
w = length(win);
if h == 0
    
    
    h = floor(w/2);
end
c = 1;

d = zeros((1+f/2),1+fix((s-f)/h));
for b = 0:h:(s-f)
u = win.*x((b+1):(b+f));
t = fft(u);
d(:,c) = t(1:(1+f/2))';
c = c+1;
end;

if nargout == 0
tt = [0:size(d,2)]*h/sr;
ff = [0:size(d,1)]*sr/f;
imagesc(tt,ff,20*log10(abs(d)));
axis('xy');
xlabel('time / sec');
ylabel('freq / Hz')

else

D = d;
end
