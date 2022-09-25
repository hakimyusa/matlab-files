function [im_seq_y] = func_read_cif_luminanance_only(in_file_name,max_frames_num,nColumn,nRow)

[fid message]= fopen(in_file_name,'rb');

if (nargin<3)
    if length(strfind(in_file_name, '.qcif')) == 0
        nRow = 288;
        nColumn = 352;
    else
        nRow = 288 / 2;
        nColumn = 352 / 2;
    end
end


%%%Read now the wanted frames
counter_frame=1;
while (1 && counter_frame<=max_frames_num)
    %reading Y (luminance) component
	img_y = fread(fid, nRow * nColumn, 'uchar');
    
    if (numel(img_y)<nRow * nColumn)
        break;
    end

    img_y = reshape(img_y, nColumn, nRow);
    im_seq_y(:,:,counter_frame) = img_y';
       
    %reading U component    
    img_u = fread(fid, nRow * nColumn / 4, 'uchar'); 
    %reading V component
    img_v = fread(fid, nRow * nColumn / 4, 'uchar');   
    
    counter_frame=counter_frame+1;
    
    if (feof(fid))
        break;
    end
end

fclose(fid);
disp('Sequence has been read');
