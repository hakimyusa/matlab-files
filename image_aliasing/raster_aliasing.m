clear all;
close all;

% read image
filename = 'barbara.gif';

if exist(filename,'file') == 0
    % read file from URL
    f = webread('http://users.cs.cf.ac.uk/Dave.Marshall/Multimedia/Lecture_Examples/image_aliasing/barbara.gif');
else
    f = imread('barbara.gif');
end

[ysize,xsize] = size(f);


fps = 10;
x_step = 5;
gross_frames = 600;

mov_pics = uint8(zeros(ysize,xsize,1,floor(gross_frames/x_step)));
mov_specs = uint8(zeros(ysize,xsize,1,floor(gross_frames/x_step)));


% We create a loop to progressively subsample the image and recale it back to original size, storing mov_pics and mov_pics frames as we go.

for xshrink = 0:x_step:gross_frames-1
    
    desiredxsize = xsize - xshrink;
    scale_shrink = desiredxsize / xsize;
    
    T = affine2d([scale_shrink 0 0; 0 scale_shrink 0; 0 0 1]);
    f2 = imwarp(f,T);
    [currentysize, currentxsize] = size(f2);
    
    scale_boost = xsize / currentxsize;
   
    Tinv = affine2d([scale_boost 0 0; 0 scale_boost 0; 0 0 1]);
   
    f3 = imwarp(f2,Tinv, 'OutputView',imref2d(size(f)));
    Fd = fftshift(log(1+abs(fft2(f3))));
 
    
    mov_pics(:,:,:,xshrink/x_step+1) = f3;
    mov_specs(:,:,:,xshrink/x_step+1)= uint8(256*Fd/max(max(Fd)));
end

% Play mov_pics: Not how more aliasing in introduced as the sub-sampling and resizing increases
	
pics_mov = immovie(mov_pics,gray(256));
implay(pics_mov,fps);

%	Play mov_specs: Note how the frequencies range decreases as the sub-sampling and resizing increases

specs_mov = immovie(mov_specs,gray(256));
implay(specs_mov,fps);