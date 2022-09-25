clear all;
close all;
imRGB = imread('parrots.jpg');
figure, imshow(imRGB), title('RGB Image');

% Konversi ke 8-bit
[im8bit, cmap8bit] = rgb2ind(imRGB,256);

figure, imshow(im8bit, cmap8bit), title('24-8 Bit Image');
figure, rgbplot(cmap8bit), title('24-8 Bit Cmap');

% Konversi ke 4-bit
[im4bit, cmap4bit] = rgb2ind(imRGB, 16);

figure, imshow(im4bit, cmap4bit), title('24-4 Bit Image');
figure, rgbplot(cmap4bit), title('24-4 Bit Cmap');

% Gif (8bit) Cmap.
[imGIF, cmapGIF] = imread('parrots.gif');
figure, imshow(imGIF, cmapGIF), title('24-8 Bit Cmap');
figure, rgbplot(cmap8bit), title('GIF (8 Bit) Cmap');

% Merubah Colourmap
figure, imshow(imGIF, cmapGIF), title('Jet Cmap');
%colormap('jet');

% Contoh konversi pada ruang warna berbeda
hsv_image24 = rgb2hsv(imRGB); % 24-bit
figure, imshow(hsv_image24), title('HSV 24-bit Image');
cmap_hsv8 = rgb2hsv(cmapGIF); % 8-bit

figure, imshow(imGIF,cmap_hsv8), title('HSV 8-bit Cmap Image');
figure, imshow(imRGB(:,:,1)), title('RGB R plane');
figure, imshow(imRGB(:,:,2)), title('RGB G Plane');
figure, imshow(imRGB(:,:,3)), title('RGB B Plane');
figure, imshow(hsv_image24(:,:,1)), title('HSV H plane');
figure, imshow(hsv_image24(:,:,2)), title('HSV S Plane');
figure, imshow(hsv_image24(:,:,3)), title('HSV V Plane');
