function valt = chkcategory(valt,category)

% if category==0
%     if (valt 0= 2 & valt <=3)
%         valt=valt;
%     else 
%         valt=bitcmp(valt,category);
%     end
% end

if category==1
    if valt == 1
        valt=valt;
    else 
        valt = - bitcmp(valt,category);
    end
end

if category==2
    if (valt >= 2 & valt <=3)
        valt = valt;
    else 
        valt = - bitcmp(valt,category);
    end
end

if category==3
    if (valt >= 4 & valt <=7)
        valt=valt;
    else 
        valt = - bitcmp(valt,category);
    end
end

if category==4
    if (valt >= 8 & valt <=15)
        valt=valt;
    else 
        valt = - bitcmp(valt,category);
    end
end

if category==5
    if (valt >= 16 & valt <=31)
        valt=valt;
    else 
        valt = - bitcmp(valt,category);
    end
end

if category==6
    if (valt >= 32 & valt <=63)
        valt=valt;
    else 
        valt = - bitcmp(valt,category);
    end
end

if category==7
    if (valt >= 64 & valt <=127)
        valt=valt;
    else 
        valt = - bitcmp(valt,category);
    end
end

if category==8
    if (valt >= 128 & valt <=255)
        valt=valt;
    else 
        valt = - bitcmp(valt,category);
    end
end

if category==9
    if (valt >= 256 & valt <=511)
        valt=valt;
    else 
        valt = - bitcmp(valt,category);
    end
end

if category==10
    if (valt >= 512 & valt <=1023)
        valt=valt;
    else 
        valt = - bitcmp(valt,category);
    end
end
       