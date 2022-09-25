function [im_seq_y im_seq_u im_seq_v] = func_read_cif(in_file_name,start_frame,nFrame,nColumn,nRow)

[fid message]= fopen(in_file_name,'rb');

if (nargin<4)
    if length(strfind(in_file_name, '.qcif')) == 0
        nRow = 288;
        nColumn = 352;
    else
        nRow = 288 / 2;
        nColumn = 352 / 2;
    end
end

%%Skip until start_frame
for i = 1: start_frame-1 
	fread(fid, nRow * nColumn, 'uchar');
    fread(fid, nRow * nColumn / 4, 'uchar');
    fread(fid, nRow * nColumn / 4, 'uchar');
end

%%%Read now the wanted frames
counter_frame=1;
for i = start_frame: start_frame+nFrame-1
    %reading Y component 
	img_y = fread(fid, nRow * nColumn, 'uchar');
    img_y = reshape(img_y, nColumn, nRow);
    im_seq_y(:,:,counter_frame) = img_y';
       
    %reading U component    
    img_u = fread(fid, nRow * nColumn / 4, 'uchar');
    img_u = reshape(img_u, nColumn/2, nRow/2);
    im_seq_u(:,:,counter_frame) = img_u';

    %reading V component
    img_v = fread(fid, nRow * nColumn / 4, 'uchar');
    img_v = reshape(img_v, nColumn/2, nRow/2);
    im_seq_v(:,:,counter_frame) = img_v';
    
    counter_frame=counter_frame+1;

end

fclose(fid);
disp('Sequence has been read');
