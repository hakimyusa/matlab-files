clear all;
close all;


sampfreq = 15;
rotfreq = 15;

rotstep= 360/rotfreq;

% read image
filename = 'spokesR.gif';

if exist(filename,'file') == 0
    % read file from URL
    [im, cmap] = webread('http://users.cs.cf.ac.uk/Dave.Marshall/Multimedia/Lecture_Examples/image_aliasing/spokesR.gif');
else
    [im, cmap] = imread('spokesR.gif');
end



[orign origm] = size(im);
offx = floor(orign/2);
offy = floor(orign/2);

% Create Movie of just 1 complete rotation of wheel --- NO SAMPLING Effectively 

movie_wheel = uint8(zeros(orign,origm,1,rotfreq));

for i = 0:rotstep:359
    IMR = imrotate(im,-1*i,'crop');
      
    movie_wheel(:,:,:,i/rotstep+1) = IMR;
    
end

mov = immovie(movie_wheel,cmap);
implay(mov,sampfreq);

% Create Movie of rotating of wheel at sampling frequency


rotstep = mod(360/(sampfreq/rotfreq),360);

movie_wheel = uint8(zeros(orign,origm,1,rotfreq));

for i = 0:14
    
    rot = i*rotstep;
    
    IMR = imrotate(im,-1*rot,'crop');
    
    movie_wheel(:,:,:,i+1) = IMR;
    
end

mov = immovie(movie_wheel,cmap);
implay(mov,sampfreq);

% Create Movie of rotation of wheel above sampling frequency

rotfreq = 29;

rotstep = mod(360/(sampfreq/rotfreq),360);

movie_wheel = uint8(zeros(orign,origm,1,rotfreq));

for i = 0:14
    
rot = i*rotstep;
IMR = imrotate(im,-1*rot,'crop');

movie_wheel(:,:,:,i+1) = IMR;

end

mov = immovie(movie_wheel,cmap);
implay(mov,sampfreq);




