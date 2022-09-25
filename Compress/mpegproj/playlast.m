function playlast(n)

if isempty(n)
    n = 5;
end

load lastmov

for i = 1:size(mov,4)
    m(i).cdata = uint8([mov(:,:,:,i) mov2(:,:,:,i)]);
    m(i).colormap = [];
end

figuresc([0.9 0.5])
movie(m,n,10)
