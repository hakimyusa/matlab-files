function basecode=tableDC(category)

BaseCodes={...
'00';
'010';
'011';
'100';
'101';
'110';
'1110';
'11110';
'111110';
'1111110';
'11111110';
'111111110'};
   
basecode = BaseCodes{category+1};
   


% if category==0
%     basecode='00';
% elseif category==1
%     basecode='010';
% elseif category==2
%     basecode='011';
% elseif category==3
%     basecode='100';
% elseif category==4
%     basecode='101';
% elseif category==5
%     basecode='110';
% elseif category==6
%     basecode='1110';
% elseif category==7
%     basecode='11110';
% elseif category==8
%     basecode='111110';
% elseif category==9
%     basecode='1111110';
% elseif category==10
%     basecode='11111110';
% elseif category==11
%     basecode='111111110';
% end    
