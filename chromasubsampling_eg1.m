clear all, close all;

% Single iteration Chroma subsampling

imRGB = imread('parrots.jpg');
figure,  imshow(imRGB), title('RGB Full Image');

imYIQ = rgb2ntsc(imRGB);

% Subsample the I and Q Channels  4:2:0 Type Subsampling 

imYIQsubI = imresize(imYIQ(:,:,2),0.5,'bilinear');
imYIQsubQ = imresize(imYIQ(:,:,3),0.5,'bilinear');

% We have have size image so resample back up

imYIQupsampI = imresize(imYIQsubI,2);
imYIQupsampQ = imresize(imYIQsubQ,2);

reconstruct_imYIQ= imYIQ;  % Copy YIQ keep Y;
reconstruct_imYIQ(:,:,2) = imYIQupsampI;
reconstruct_imYIQ(:,:,3) = imYIQupsampQ;

% Remake RGB and show

reconstruct_imRGB = uint8(256*ntsc2rgb(reconstruct_imYIQ));
figure, imshow(reconstruct_imRGB); title('Reconstructed RGB Full Image');


% show  R,G,B plane errors

figure, imshow(256*abs(imRGB(:,:,1) - reconstruct_imRGB(:,:,1))); title('Reconstructed R Error');
figure, imshow(256*abs(imRGB(:,:,2) - reconstruct_imRGB(:,:,2))); title('Reconstructed G Error');
figure, imshow(256*abs(imRGB(:,:,3) - reconstruct_imRGB(:,:,3))); title('Reconstructed B Error');
