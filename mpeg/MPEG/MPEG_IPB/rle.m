function [valq,runq]=rle(result)


counter=0;
j=1;
for i=1:numel(result)  
    if result(i)~=0
        val(j)=result(i);
        run(j)=counter;
        j=j+1;
        counter=0;
    elseif result(i)==0
        counter=counter+1;
        if counter==15 
            val(j)=result(i);
            run(j)=counter;
            j=j+1;
            counter=0;
        end
    end
end
%%%%%check if last value has run of zero


j=j-1;
temp_index = 0;
for i=j:-1:1
    if i == 1
        if val(i) ~=0 
            val(i+1)= 0;
            run(i+1)= 0;
            temp_index = i+1 ;
            break;
        elseif val(i) ==0  
            val(i)= 0;
            run(i)= 0;
            temp_index = i ;
            break;
        end
    elseif val(i) ~=0 
        val(i+1)= 0;
        run(i+1)= 0;
        temp_index = i+1 ;
        break;
    end
end


   


if temp_index~=0
     valq(1:temp_index)=val(1:temp_index);
     runq(1:temp_index)=run(1:temp_index);
 else
     valq(1)=0;
     runq(1)=0;
end


