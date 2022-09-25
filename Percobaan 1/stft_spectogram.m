load handel;
n = 512;
nhop = n/4;
Y = stft(y,n,n,nhop);
specy = abs(Y)/n;
imshow(flipud(255*specy));
colormap(hsv);
