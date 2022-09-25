function [B ,motionVect, flag] = bFrameProc(B,I,P,array,mbSize,p)


        %calculating MV  and Zero Matrixes  from I
        [motionVect1, zeroMatrixCount1]=BmotionEstARPS(B,I,mbSize,p);
              
        %calculating MV  and Zero Matrixes  from P
        [motionVect2, zeroMatrixCount2]=BmotionEstARPS(B,P,mbSize,p);
        
        
        %chosing btw B2's
        if zeroMatrixCount1 <= zeroMatrixCount2
            flag=0;
            B=bFrameCal(B,I,array,mbSize,p,motionVect1);
            motionVect=motionVect1;
        else
            flag=1;
            B=bFrameCal(B,P,array,mbSize,p,motionVect2);
            motionVect=motionVect2;
        end


