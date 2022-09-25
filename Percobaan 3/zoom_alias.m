im = imread('parrots.jpg');
zoom = 4
% Mengambil dimensi citra dan hitung pusat dan window untuk zoom;

[n m o] = size(im)
% Pusat citra
nmid = n/2;
mmid= m/2;
xoff = n/(zoom*2);
yoff = m/(zoom*2);
%Potong bagian citra dari pusatnya yang proporsional untuk zoom

newim = im(nmid-xoff:nmid+xoff,mmid-yoff:mmid+yoff,:);
%zoom image use imresize function
newimzoom = imresize(newim,zoom);

% show images
figure(1)
imshow(im);
title('Original Image')
figure(2)
imshow(newim);
title('Original Image Cropped')
figure(3)
imshow(newimzoom);
title('Zoomed Image (Aliasing Artifacts)')