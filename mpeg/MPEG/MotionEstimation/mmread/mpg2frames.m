%Reads an mpeg file and capture its frames 
%Puts them into a N1xN2*N array
function [im_sequence]=mpg2frames(filename,first_frame,last_frame,step)
[video audio]=mmread(filename,first_frame:step:last_frame,false,true);
counter=1;
for (n=first_frame:step:last_frame)
    im_sequence(:,:,counter)=rgb2gray(video.frames(counter).cdata);
    counter=counter+1;
end