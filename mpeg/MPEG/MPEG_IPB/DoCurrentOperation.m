function handles = DoCurrentOperation(handles)

OperationOnTheFly(true,handles);


%%%The current Group of Pictures (GOP) starts from the i-th frame
%%%It is the j-th GOP
j=round(get(handles.GOPSlider,'value'));
i=(j-1)*9+1;

%%%The current operation is given from the Operation Slider
curOperation = round(get(handles.operationSlider,'value'));

%%%%%%Various Parameters for Motion Estimation and Encoding
estAlgo = 3; %%%MOTION ESTIMATION ALGORITHM
P = 3; %%%%%%SEARCH RANGE
mbSize=16; %%%MacroBlock SIZE
array=handles.array;


switch (curOperation)
    case {1}     %%%%%%%%%%%%%%%%%%%%%%% I1 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        handles.identifier=1;        
        
        %%%Check if already calculated
        AlreadyCalculated = checkAllReadyCalculated(handles,'I1d',j);
        if (~AlreadyCalculated) %%%If NOT already calculated            
            [JO,JQ]=IforwardDCT(handles.I1{j},array);
            [X,B]= makeLayers(JQ);
            XX=length(X); BB=length(B);
            flag = 0; motionVect=[]; %%%Not required for Intra-decoding
            handles = decoder(X,B,motionVect,flag,handles);
            handles = SetCurrentOperationHandleVariables(handles,XX,BB,flag,motionVect,JO,JQ);
        end
       
        
        
    case {2}  %%%%%%%%%%%%%%%%%%%%%%% P4 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        handles.identifier=4;
        
        %%%Check if already calculated 
        AlreadyCalculated = checkAllReadyCalculated(handles,'P4d',j);
        if (~AlreadyCalculated) %%%If NOT already calculated        
            [bufferP4,streamP4,motionVect]=compensatedFrame(handles.P4{j},handles.I1d{j},mbSize,P,array,estAlgo);
            [X,B]= makeLayers(streamP4);
            XX=length(X); BB=length(B);
            %calling decoder
            flag = 0; %%%Not required for P-decoding
            handles = decoder(X,B,motionVect,flag,handles);
            handles = SetCurrentOperationHandleVariables(handles,XX,BB,flag,motionVect,0,0);
        end
        
        
        
    case {3}  %%%%%%%%%%%%%%%%%%%%%%% B2 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        handles.identifier=2;
        
        %%%Check if already calculated
        AlreadyCalculated = checkAllReadyCalculated(handles,'B2d',j);
        if (~AlreadyCalculated) %%%If NOT already calculated   
            [Bt ,motionVect, flag] = bFrameProc(handles.B2{j},handles.I1d{j},handles.P4d{j},1.4*array,mbSize,P);
            [X,B]= makeLayers(Bt);
            XX=length(X); BB=length(B);       
            %calling decoder
            handles = decoder(X,B,motionVect,flag,handles);
            handles = SetCurrentOperationHandleVariables(handles,XX,BB,flag,motionVect,0,0);      
        end
       
        
    case {4}  %%%%%%%%%%%%%%%%%%%%%%% B3 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        handles.identifier=3;
        
        %%%Check if already calculated
        AlreadyCalculated = checkAllReadyCalculated(handles,'B3d',j);
        if (~AlreadyCalculated) %%%If NOT already calculated   
            [B3t ,motionVect, flag] = bFrameProc(handles.B3{j},handles.I1d{j},handles.P4d{j},1.4*array,mbSize,P);
            [X,B]= makeLayers(B3t);
            XX=length(X); BB=length(B);      
            %calling decoder
            handles = decoder(X,B,motionVect,flag,handles);
            handles = SetCurrentOperationHandleVariables(handles,XX,BB,flag,motionVect,0,0);
        end
       
        
   case {5}  %%%%%%%%%%%%%%%%%%%%%%% P7 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        handles.identifier=7;
        
        %%%Check if already calculated
        AlreadyCalculated = checkAllReadyCalculated(handles,'P7d',j);
        if (~AlreadyCalculated) %%%If NOT already calculated        
            [bufferP7,streamP7,motionVect]=compensatedFrame(handles.P7{j},handles.P4d{j},mbSize,P,array,estAlgo);
            [X,B]= makeLayers(streamP7);
            XX=length(X); BB=length(B);
            %calling decoder
            flag = 0; %%%Not required for P-decoding
            handles = decoder(X,B,motionVect,flag,handles);
            handles = SetCurrentOperationHandleVariables(handles,XX,BB,flag,motionVect,0,0);
        end
        
        
   
    case {6}  %%%%%%%%%%%%%%%%%%%%%%% B5 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        handles.identifier=5;
        
        %%%Check if already calculated
        AlreadyCalculated = checkAllReadyCalculated(handles,'B5d',j);
        if (~AlreadyCalculated) %%%If NOT already calculated   
            [Bt ,motionVect, flag] = bFrameProc(handles.B5{j},handles.P4d{j},handles.P7d{j},1.4*array,mbSize,P);
            [X,B]= makeLayers(Bt);
            XX=length(X); BB=length(B);
            %calling decoder
            handles = decoder(X,B,motionVect,flag,handles);
            handles = SetCurrentOperationHandleVariables(handles,XX,BB,flag,motionVect,0,0);
        end
     
        
    case {7}  %%%%%%%%%%%%%%%%%%%%%%% B6 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        handles.identifier=6;
        
        %%%Check if already calculated
        AlreadyCalculated = checkAllReadyCalculated(handles,'B6d',j);
        if (~AlreadyCalculated) %%%If NOT already calculated   
            [Bt ,motionVect, flag] = bFrameProc(handles.B6{j},handles.P4d{j},handles.P7d{j},1.4*array,mbSize,P);
            [X,B]= makeLayers(Bt);
            XX=length(X); BB=length(B);
            %calling decoder
            handles = decoder(X,B,motionVect,flag,handles);
            handles = SetCurrentOperationHandleVariables(handles,XX,BB,flag,motionVect,0,0);
        end
      
        
   case {8}  %%%%%%%%%%%%%%%%%%%%%%% I10 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        handles.identifier=10;
        
        %%%Check if already calculated
        AlreadyCalculated = checkAllReadyCalculated(handles,'I10d',j);
        if (~AlreadyCalculated) %%%If NOT already calculated            
            [JO,JQ]=IforwardDCT(handles.I10{j},array);
            [X,B]= makeLayers(JQ);
            XX=length(X); BB=length(B);
            flag = 0; motionVect=[]; %%%Not required for Intra-decoding
            handles = decoder(X,B,motionVect,flag,handles);
            handles = SetCurrentOperationHandleVariables(handles,XX,BB,flag,motionVect,JO,JQ);
        end
       
        
   case {9}  %%%%%%%%%%%%%%%%%%%%%%% B8 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        handles.identifier=8;
        
        %%%Check if already calculated
        AlreadyCalculated = checkAllReadyCalculated(handles,'B8d',j);
        if (~AlreadyCalculated) %%%If NOT already calculated   
            [Bt ,motionVect, flag] = bFrameProc(handles.B8{j},handles.P7d{j},handles.I10d{j},1.4*array,mbSize,P);
            [X,B]= makeLayers(Bt);
            XX=length(X); BB=length(B);    
            %calling decoder
            handles = decoder(X,B,motionVect,flag,handles);
            handles = SetCurrentOperationHandleVariables(handles,XX,BB,flag,motionVect,0,0);
        end
      
        
   case {10}  %%%%%%%%%%%%%%%%%%%%%%% B9 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        handles.identifier=9;
        
        %%%Check if already calculated
        AlreadyCalculated = checkAllReadyCalculated(handles,'B9d',j);
        if (~AlreadyCalculated) %%%If NOT already calculated   
            [Bt ,motionVect, flag] = bFrameProc(handles.B9{j},handles.P7d{j},handles.I10d{j},1.4*array,mbSize,P);
            [X,B]= makeLayers(Bt);
            XX=length(X); BB=length(B);
            %calling decoder
            handles = decoder(X,B,motionVect,flag,handles);
            handles = SetCurrentOperationHandleVariables(handles,XX,BB,flag,motionVect,0,0);            
            
        end
      
      
end

handles = DrawCurrentResults(handles);

OperationOnTheFly(false,handles);