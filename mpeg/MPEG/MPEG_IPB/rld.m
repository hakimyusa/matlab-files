function de = rld(valq,runq)
if valq(1)==0 & runq(1)==0
    de(1)=0;
    return
else
	sv=size(valq);
	for i=1:sv(2)
        if valq(i)==0 & runq(i)==0
            part=i;
        end
	end
	%part=i;
	%s2=size(part);
	
	flag =0;
	j=0;
	i=0;
	while j~=part-1
        j=j+1;
        if runq(j)==0
            i=i+1;
            de(i)=valq(j);
            
        elseif runq(j)~=0
            b=runq(j);
            while b~=0
                i=i+1;
                de(i)=0;
                
                b=b-1;
                if b==0
                    i=i+1;
                    de(i)=valq(j);
                    %i=i+1;
                end
            end
                
        end
	
	end
end