function basecode=tableAC2(run,category)

if (run==0 && category==0)
    basecode='1010';
    return;
elseif (run==15 && category==0)
    basecode='11111111111111111';
    return;
end


BaseCodes={...
'00';
'01';
'100';
'1011';
'11010';
'111000';
'1111000';
'1111110110';
'1111111110000010';
'1111111110000011';
'1100';
'111001';
'1111001';
'111110110';
'1111111010';
'1111111110000100';
'1111111110000101';
'1111111110000110';
'1111111110000111';
'1111111110001000';
'11011';
'11111000';
'1111110111';
'1111111110001001';
'1111111110001010';
'1111111110001011';
'1111111110001100';
'1111111110001101';
'1111111110001110';
'1111111110001111';
'111010';
'111110111';
'11111110111';
'1111111110010000';
'1111111110010001';
'1111111110010010';
'1111111110010011';
'1111111110010100';
'1111111110010101';
'1111111110010110';
'111011';
'1111111000';
'1111111110010111';
'1111111110011000';
'1111111110011001';
'1111111110011010'; 
'1111111110011011';
'1111111110011100'; 
'1111111110011101';
'1111111110011110';
'1111010';
'1111111001';
'1111111110011111';
'1111111110100000';
'1111111110100001';
'1111111110100010';
'1111111110100011';
'1111111110100100';
'1111111110100101';
'1111111110100110';
'1111011';
'11111111000';
'1111111110100111';
'1111111110101000';
'1111111110101001';
'1111111110101010';
'1111111110101011';
'1111111110101100';
'1111111110101101';
'1111111110101110';
'11111001';
'11111111001';
'1111111110101111';
'1111111110110000';
'1111111110110001';
'1111111110110010';
'1111111110110011';
'1111111110110100'; 
'1111111110110101';
'1111111110110110';
'11111010';
'111111111000000';
'1111111101110111';
'1111111110111000';
'1111111110111001';
'1111111110111010';
'1111111110111011';
'1111111110111100';
'1111111110111101';
'1111111110111110'; 
'111111000';
'1111111110111111';
'1111111111000000';
'1111111111000001';
'1111111111000010';
'1111111111000011';
'1111111111000100';
'1111111111000101';
'1111111111000110';
'1111111111000111';
'111111001';
'1111111111001000';
'1111111111001001';
'1111111111001010';
'1111111111001011';
'1111111111001100';
'1111111111001101';
'1111111111001110';
'1111111111001111';
'1111111111010000';
'111111010';
'1111111111010001';
'1111111111010010';
'1111111111010011';
'1111111111010100';
'1111111111010101';
'1111111111010110';
'1111111111010111';
'1111111111011000';
'1111111111011001';
'11111111111111110'; 
'1111111111011010';
'1111111111011011';
'1111111111011100';
'1111111111011101';
'1111111111011110'; 
'1111111111011111';
'1111111111100000'; 
'1111111111100001';
'1111111111100010';
'11111111010';
'1111111111100011';
'1111111111100100';
'1111111111100101';
'1111111111100110';
'1111111111100111';
'1111111111101000';
'1111111111101001';
'1111111111101010';
'1111111111101011';
'111111110110';
'1111111111101100';
'1111111111101101';
'1111111111101110';
'1111111111101111';
'1111111111110000'; 
'1111111111110001'; 
'1111111111110010';
'1111111111110011';
'1111111111110100'; 
'1111111111110101';
'1111111111110110';
'1111111111110111';
'1111111111111000';
'1111111111111001';
'1111111111111010';
'1111111111111011';
'1111111111111100'; 
'1111111111111101'; 
'1111111111111110'};

basecode=BaseCodes{run*10+category};





% %%%%%%%%%zero%%%%%%%%%%
% if run==0 & category==0
%     basecode='1010';
% elseif run==0 & category==1
%     basecode='00';
% elseif run==0 & category==2
%     basecode='01';
% elseif run==0 & category==3
%     basecode='100';
% elseif run==0 & category==4
%     basecode='1011';
% elseif run==0 & category==5
%     basecode='11010';
% elseif run==0 & category==6
%     basecode='111000';
% elseif run==0 & category==7
%     basecode='1111000';
% elseif run==0 & category==8
%     basecode='1111110110';
% elseif run==0 & category==9
%     basecode='1111111110000010';
% elseif run==0 & category==10
%     basecode='1111111110000011';
% %%%%%%%ones%%%%%%%%%%
% elseif run==1 & category==1
%     basecode='1100';
% elseif run==1 & category==2
%     basecode='111001';
% elseif run==1 & category==3
%     basecode='1111001';
% elseif run==1 & category==4
%     basecode='111110110';
% elseif run==1 & category==5
%     basecode='1111111010';
% elseif run==1 & category==6
%     basecode='1111111110000100'; %%%
% elseif run==1 & category==7
%     basecode='1111111110000101';
% elseif run==1 & category==8
%     basecode='1111111110000110';
% elseif run==1 & category==9
%     basecode='1111111110000111';
% elseif run==1 & category==10
%     basecode='1111111110001000';
% 
% %%%%%%%twos%%%%%%%%%%
% elseif run==2 & category==1
%     basecode='11011';
% elseif run==2 & category==2
%     basecode='11111000';
% elseif run==2 & category==3
%     basecode='1111110111';
% elseif run==2 & category==4
%     basecode='1111111110001001';
% elseif run==2 & category==5
%     basecode='1111111110001010';
% elseif run==2 & category==6
%     basecode='1111111110001011';
% elseif run==2 & category==7
%     basecode='1111111110001100';
% elseif run==2 & category==8
%     basecode='1111111110001101';
% elseif run==2 & category==9
%     basecode='1111111110001110';
% elseif run==2 & category==10
%     basecode='1111111110001111';
%     
% %%%%%%%threes%%%%%%%%%%
% elseif run==3 & category==1
%     basecode='111010';
% elseif run==3 & category==2
%     basecode='111110111';
% elseif run==3 & category==3
%     basecode='11111110111';
% elseif run==3 & category==4
%     basecode='1111111110010000';
% elseif run==3 & category==5
%     basecode='1111111110010001';
% elseif run==3 & category==6
%     basecode='1111111110010010';
% elseif run==3 & category==7
%     basecode='1111111110010011';
% elseif run==3 & category==8
%     basecode='1111111110010100';
% elseif run==3 & category==9
%     basecode='1111111110010101';
% elseif run==3 & category==10
%     basecode='1111111110010110';
% %%%%%%%fours%%%%%%%%%%
% elseif run==4 & category==1
%     basecode='111011';
% elseif run==4 & category==2
%     basecode='1111111000';
% elseif run==4 & category==3
%     basecode='1111111110010111';
% elseif run==4 & category==4
%     basecode='1111111110011000';
% elseif run==4 & category==5
%     basecode='1111111110011001';
% elseif run==4 & category==6
%     basecode='1111111110011010'; %%%
% elseif run==4 & category==7
%     basecode='1111111110011011';
% elseif run==4 & category==8
%     basecode='1111111110011100'; %%%%
% elseif run==4 & category==9
%     basecode='1111111110011101';
% elseif run==4 & category==10
%     basecode='1111111110011110';
% %%%%%%%fives%%%%%%%%%%
% elseif run==5 & category==1
%     basecode='1111010';
% elseif run==5 & category==2
%     basecode='1111111001';
% elseif run==5 & category==3
%     basecode='1111111110011111';
% elseif run==5 & category==4
%     basecode='1111111110100000';
% elseif run==5 & category==5
%     basecode='1111111110100001';
% elseif run==5 & category==6
%     basecode='1111111110100010';
% elseif run==5 & category==7
%     basecode='1111111110100011';
% elseif run==5 & category==8
%     basecode='1111111110100100';
% elseif run==5 & category==9
%     basecode='1111111110100101';
% elseif run==5 & category==10
%     basecode='1111111110100110';
% %%%%%%%sixes%%%%%%%%%%
% elseif run==6 & category==1
%     basecode='1111011';
% elseif run==6 & category==2
%     basecode='11111111000';
% elseif run==6 & category==3
%     basecode='1111111110100111';
% elseif run==6 & category==4
%     basecode='1111111110101000';
% elseif run==6 & category==5
%     basecode='1111111110101001';
% elseif run==6 & category==6
%     basecode='1111111110101010';
% elseif run==6 & category==7
%     basecode='1111111110101011';
% elseif run==6 & category==8
%     basecode='1111111110101100';
% elseif run==6 & category==9
%     basecode='1111111110101101';
% elseif run==6 & category==10
%     basecode='1111111110101110';
% %%%%%%%sevens%%%%%%%%%%
% elseif run==7 & category==1
%     basecode='11111001';
% elseif run==7 & category==2
%     basecode='11111111001';
% elseif run==7 & category==3
%     basecode='1111111110101111';
% elseif run==7 & category==4
%     basecode='1111111110110000';
% elseif run==7 & category==5
%     basecode='1111111110110001';
% elseif run==7 & category==6
%     basecode='1111111110110010';
% elseif run==7 & category==7
%     basecode='1111111110110011';
% elseif run==7 & category==8
%     basecode='1111111110110100'; 
% elseif run==7 & category==9
%     basecode='1111111110110101';%%%
% elseif run==7 & category==10
%     basecode='1111111110110110';
% %%%%%%%eights%%%%%%%%%%
% elseif run==8 & category==1
%     basecode='11111010';
% elseif run==8 & category==2
%     basecode='111111111000000';
% elseif run==8 & category==3
%     basecode='1111111101110111';
% elseif run==8 & category==4
%     basecode='1111111110111000';
% elseif run==8 & category==5
%     basecode='1111111110111001';
% elseif run==8 & category==6
%     basecode='1111111110111010';
% elseif run==8 & category==7
%     basecode='1111111110111011';
% elseif run==8 & category==8
%     basecode='1111111110111100';
% elseif run==8 & category==9
%     basecode='1111111110111101';
% elseif run==8 & category==10
%     basecode='1111111110111110'; %%%
% %%%%%%%nines%%%%%%%%%%
% elseif run==9 & category==1
%     basecode='111111000';
% elseif run==9 & category==2
%     basecode='1111111110111111';
% elseif run==9 & category==3
%     basecode='1111111111000000';
% elseif run==9 & category==4
%     basecode='1111111111000001';
% elseif run==9 & category==5
%     basecode='1111111111000010';
% elseif run==9 & category==6
%     basecode='1111111111000011';
% elseif run==9 & category==7
%     basecode='1111111111000100';
% elseif run==9 & category==8
%     basecode='1111111111000101';
% elseif run==9 & category==9
%     basecode='1111111111000110';
% elseif run==9 & category==10
%     basecode='1111111111000111';
% %%%%%%%tens%%%%%%%%%%
% elseif run==10 & category==1
%     basecode='111111001';
% elseif run==10 & category==2
%     basecode='1111111111001000';
% elseif run==10 & category==3
%     basecode='1111111111001001';
% elseif run==10 & category==4
%     basecode='1111111111001010';
% elseif run==10 & category==5
%     basecode='1111111111001011';
% elseif run==10 & category==6
%     basecode='1111111111001100';
% elseif run==10 & category==7
%     basecode='1111111111001101';
% elseif run==10 & category==8
%     basecode='1111111111001110';
% elseif run==10 & category==9
%     basecode='1111111111001111';
% elseif run==10 & category==10
%     basecode='1111111111010000';
% %%%%%%%elevens%%%%%%%%%%
% elseif run==11 & category==1
%     basecode='111111010';
% elseif run==11 & category==2
%     basecode='1111111111010001';
% elseif run==11 & category==3
%     basecode='1111111111010010';
% elseif run==11 & category==4
%     basecode='1111111111010011';
% elseif run==11 & category==5
%     basecode='1111111111010100';
% elseif run==11 & category==6
%     basecode='1111111111010101';
% elseif run==11 & category==7
%     basecode='1111111111010110';
% elseif run==11 & category==8
%     basecode='1111111111010111';
% elseif run==11 & category==9
%     basecode='1111111111011000';
% elseif run==11 & category==10
%     basecode='1111111111011001';
% %%%%%%%twelevs%%%%%%%%%%
% elseif run==12 & category==1
%     basecode='11111111111111110'; %%%%
% elseif run==12 & category==2
%     basecode='1111111111011010';
% elseif run==12 & category==3
%     basecode='1111111111011011';
% elseif run==12 & category==4
%     basecode='1111111111011100';
% elseif run==12 & category==5
%     basecode='1111111111011101';
% elseif run==12 & category==6
%     basecode='1111111111011110'; %%%
% elseif run==12 & category==7
%     basecode='1111111111011111';
% elseif run==12 & category==8
%     basecode='1111111111100000'; %%%
% elseif run==12 & category==9
%     basecode='1111111111100001';
% elseif run==12 & category==10
%     basecode='1111111111100010';
% %%%%%%%13s%%%%%%%%%%
% elseif run==13 & category==1
%     basecode='11111111010';
% elseif run==13 & category==2
%     basecode='1111111111100011';
% elseif run==13 & category==3
%     basecode='1111111111100100';
% elseif run==13 & category==4
%     basecode='1111111111100101';
% elseif run==13 & category==5
%     basecode='1111111111100110';
% elseif run==13 & category==6
%     basecode='1111111111100111';
% elseif run==13 & category==7
%     basecode='1111111111101000';
% elseif run==13 & category==8
%     basecode='1111111111101001';
% elseif run==13 & category==9
%     basecode='1111111111101010';
% elseif run==13 & category==10
%     basecode='1111111111101011';
% %%%%%%%14s%%%%%%%%%%
% elseif run==14 & category==1
%     basecode='111111110110';
% elseif run==14 & category==2
%     basecode='1111111111101100';
% elseif run==14 & category==3
%     basecode='1111111111101101';
% elseif run==14 & category==4
%     basecode='1111111111101110';
% elseif run==14 & category==5
%     basecode='1111111111101111';
% elseif run==14 & category==6
%     basecode='1111111111110000'; %%%
% elseif run==14 & category==7
%     basecode='1111111111110001'; %%%%
% elseif run==14 & category==8
%     basecode='1111111111110010';
% elseif run==14 & category==9
%     basecode='1111111111110011';
% elseif run==14 & category==10
%     basecode='1111111111110100'; %%%
% %%%%%%%15s%%%%%%%%%%
% elseif run==15 & category==0
%     basecode='11111111111111111'; %%%
% elseif run==15 & category==1
%     basecode='1111111111110101';
% elseif run==15 & category==2
%     basecode='1111111111110110';
% elseif run==15 & category==3
%     basecode='1111111111110111';
% elseif run==15 & category==4
%     basecode='1111111111111000';
% elseif run==15 & category==5
%     basecode='1111111111111001';
% elseif run==15 & category==6
%     basecode='1111111111111010';
% elseif run==15 & category==7
%     basecode='1111111111111011';
% elseif run==15 & category==8
%     basecode='1111111111111100'; %%%
% elseif run==15 & category==9
%     basecode='1111111111111101'; %%%
% elseif run==15 & category==10
%     basecode='1111111111111110';
% end
% 
% 
% disp(basecode);
% disp(basecode1);
% if (~strcmp(basecode,basecode1))
%     disp('error');
% end
