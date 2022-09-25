function handles = DrawCurrentResults(handles)

CloseAllOpenFigures(handles);

%%%The current Group of Pictures (GOP) starts from the i-th frame
%%%It is the j-th GOP
j=round(get(handles.GOPSlider,'value'));
i=(j-1)*9+1;

%%%The current operation is given from the Operation Slider
curOperation = round(get(handles.operationSlider,'value'));


[XX,BB,flag,MotVec,JO,JQ] = GetCurrentOperationHandleVariables(handles);
BitsPerSample = (XX+BB)/numel(handles.I1{j});
switch (curOperation)
    case {1}     %%%%%%%%%%%%%%%%%%%%%%% I1 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%Show the original I1 frame
        axes(handles.I1Axes); imshow(handles.I1{j}/255); title('I1','FontName','Times New Roman','FontSize',8); drawnow;        
        
        axes(handles.I1dAxes); imshow(handles.I1d{j}/255); title(['I1d - ' num2str(BitsPerSample),' bits/pixel'],'FontName','Times New Roman','FontSize',8); drawnow;        
        
        MovePointersTo(handles,[1 0 0]);
        SetOperationText(handles,'I1 was Intra-Encoded ...');
        
        handles.Fig1 = figure('name','I1 Intra Encoding','position',[395,90,560,210]); 
        subplot(1,2,1); imshow(mat2gray(JO)); 
        title('I1: Original 8x8 block DCT coefficients','FontName','Times New Roman','FontSize',8);
        subplot(1,2,2); imshow(mat2gray(JQ)); 
        title('I1d: Quantized 8x8 block DCT coefficients','FontName','Times New Roman','FontSize',8);
        
        
    case {2}  %%%%%%%%%%%%%%%%%%%%%%% P4 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %%%Show the original P4 frame
        axes(handles.P4Axes); imshow(handles.P4{j}/255); title('P4','FontName','Times New Roman','FontSize',8); drawnow;
      
        axes(handles.P4dAxes); imshow(handles.P4d{j}/255); title(['P4d - ' num2str(BitsPerSample),' bits/pixel'],'FontName','Times New Roman','FontSize',8); drawnow;        
        MovePointersTo(handles,[4 1 0]);
        SetOperationText(handles,'P4 was P-Encoded, based on I1d...');
        
        MotVecY = reshape(MotVec(1,:),size(handles.I1{j})/16); MotVecY=MotVecY';
        MotVecX = reshape(MotVec(2,:),size(handles.I1{j})/16); MotVecX=MotVecX';
        handles.Fig2 = figure('name','P4 P-Encoding','position',[580,74,344,234]);
        h=quiver(MotVecX(end:-1:1,:),-MotVecY(end:-1:1,:),0.5,'k'); set(h,'linewidth',1); set(gca,'xtick',[],'ytick',[]);
        title('Motion vectors - Anchor Frame: I1d, Target Frame: P4','FontName','Times New Roman','FontSize',8);
        
    case {3}  %%%%%%%%%%%%%%%%%%%%%%% B2 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %%%Show the original B2 frame
        axes(handles.B2Axes); imshow(handles.B2{j}/255); title('B2','FontName','Times New Roman','FontSize',8); drawnow;        
        axes(handles.B2dAxes); imshow(handles.B2d{j}/255); title(['B2d - ' num2str(BitsPerSample),' bits/pixel'],'FontName','Times New Roman','FontSize',8); drawnow;
        
        MotVecY = reshape(MotVec(1,:),size(handles.I1{j})/16); MotVecY=MotVecY';
        MotVecX = reshape(MotVec(2,:),size(handles.I1{j})/16); MotVecX=MotVecX';
        handles.Fig3 = figure('name','B2 B-Encoding','position',[580,74,344,234]);
        h=quiver(MotVecX(end:-1:1,:),-MotVecY(end:-1:1,:),0.5,'k'); set(h,'linewidth',1); set(gca,'xtick',[],'ytick',[]);
        
        if flag==0 
            MovePointersTo(handles,[2 1 4]); 
            SetOperationText(handles,'B2 was chosen to be B-encoded based on I1d, instead of P4d...');
            title('Motion vectors - Anchor Frame: I1d, Target Frame: B2','FontName','Times New Roman','FontSize',8);
        elseif flag==1 
            MovePointersTo(handles,[2 4 1]);
            SetOperationText(handles,'B2 was chosen to be B-encoded based on P4d, instead of I1d...');
            title('Motion vectors - Anchor Frame: P4d, Target Frame: B2','FontName','Times New Roman','FontSize',8);
        end
        
        
        
    case {4}  %%%%%%%%%%%%%%%%%%%%%%% B3 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %%%Show the original B2 frame
        axes(handles.B3Axes); imshow(handles.B3{j}/255); title('B3','FontName','Times New Roman','FontSize',8); drawnow;        
        axes(handles.B3dAxes); imshow(handles.B3d{j}/255); title(['B3d - ' num2str(BitsPerSample),' bits/pixel'],'FontName','Times New Roman','FontSize',8); drawnow;
        MotVecY = reshape(MotVec(1,:),size(handles.I1{j})/16); MotVecY=MotVecY';
        MotVecX = reshape(MotVec(2,:),size(handles.I1{j})/16); MotVecX=MotVecX';
        handles.Fig4 = figure('name','B3 B-Encoding','position',[580,74,344,234]);
        h=quiver(MotVecX(end:-1:1,:),-MotVecY(end:-1:1,:),0.5,'k'); set(h,'linewidth',1); set(gca,'xtick',[],'ytick',[]);
        
        if flag==0 
            MovePointersTo(handles,[3 1 4]); 
            SetOperationText(handles,'B3 was chosen to be B-encoded based on I1d, instead of P4d...');
            title('Motion vectors - Anchor Frame: I1d, Target Frame: B3','FontName','Times New Roman','FontSize',8);
        elseif flag==1 
            MovePointersTo(handles,[3 4 1]);
            SetOperationText(handles,'B3 was chosen to be B-encoded based on P4d, instead of I1d...');
            title('Motion vectors - Anchor Frame: P4d, Target Frame: B3','FontName','Times New Roman','FontSize',8);
        end       
        
      
        
        
   case {5}  %%%%%%%%%%%%%%%%%%%%%%% P7 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %%%Show the original P7 frame
        axes(handles.P7Axes); imshow(handles.P7{j}/255); title('P7','FontName','Times New Roman','FontSize',8); drawnow;
        
        axes(handles.P7dAxes); imshow(handles.P7d{j}/255); title(['P7d - ' num2str(BitsPerSample),' bits/pixel'],'FontName','Times New Roman','FontSize',8); drawnow;
        MovePointersTo(handles,[7 4 0]);
        SetOperationText(handles,'P7 is P-Encoded, based on P4d...');
        
        MotVecY = reshape(MotVec(1,:),size(handles.I1{j})/16); MotVecY=MotVecY';
        MotVecX = reshape(MotVec(2,:),size(handles.I1{j})/16); MotVecX=MotVecX';
        handles.Fig5 = figure('name','P7 P-Encoding','position',[580,74,344,234]);
        h=quiver(MotVecX(end:-1:1,:),-MotVecY(end:-1:1,:),0.5,'k'); set(h,'linewidth',1); set(gca,'xtick',[],'ytick',[]);
        title('Motion vectors - Anchor Frame: P4d, Target Frame: P7','FontName','Times New Roman','FontSize',8);
        
    case {6}  %%%%%%%%%%%%%%%%%%%%%%% B5 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %%%Show the original B5 frame
        axes(handles.B5Axes); imshow(handles.B5{j}/255); title('B5','FontName','Times New Roman','FontSize',8); drawnow;        
        axes(handles.B5dAxes); imshow(handles.B5d{j}/255); title(['B5d - ' num2str(BitsPerSample),' bits/pixel'],'FontName','Times New Roman','FontSize',8); drawnow;
        MotVecY = reshape(MotVec(1,:),size(handles.I1{j})/16); MotVecY=MotVecY';
        MotVecX = reshape(MotVec(2,:),size(handles.I1{j})/16); MotVecX=MotVecX';
        handles.Fig6 = figure('name','B5 B-Encoding','position',[580,74,344,234]);
        h=quiver(MotVecX(end:-1:1,:),-MotVecY(end:-1:1,:),0.5,'k'); set(h,'linewidth',1); set(gca,'xtick',[],'ytick',[]);
        if flag==0 
            MovePointersTo(handles,[5 4 7]);
            SetOperationText(handles,'B5 was chosen to be B-encoded based on P4d, instead of P7d...');
            title('Motion vectors - Anchor Frame: P4d, Target Frame: B5','FontName','Times New Roman','FontSize',8);
        elseif flag==1 
            MovePointersTo(handles,[5 7 4]);
            SetOperationText(handles,'B5 was chosen to be B-encoded based on P7d, instead of P4d...');
            title('Motion vectors - Anchor Frame: P7d, Target Frame: B5','FontName','Times New Roman','FontSize',8);
        end 
        
        
        
        
    case {7}  %%%%%%%%%%%%%%%%%%%%%%% B6 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %%%Show the original B5 frame
        axes(handles.B6Axes); imshow(handles.B6{j}/255); title('B6','FontName','Times New Roman','FontSize',8); drawnow;       
        axes(handles.B6dAxes); imshow(handles.B6d{j}/255); title(['B6d - ' num2str(BitsPerSample),' bits/pixel'],'FontName','Times New Roman','FontSize',8); drawnow;
        MotVecY = reshape(MotVec(1,:),size(handles.I1{j})/16); MotVecY=MotVecY';
        MotVecX = reshape(MotVec(2,:),size(handles.I1{j})/16); MotVecX=MotVecX';
        handles.Fig7 = figure('name','B6 B-Encoding','position',[580,74,344,234]);
        h=quiver(MotVecX(end:-1:1,:),-MotVecY(end:-1:1,:),0.5,'k'); set(h,'linewidth',1); set(gca,'xtick',[],'ytick',[]); 
        if flag==0 
            MovePointersTo(handles,[6 4 7]);
            SetOperationText(handles,'B6 was chosen to be B-encoded based on P4d, instead of P7d...');
            title('Motion vectors - Anchor Frame: P4d, Target Frame: B6','FontName','Times New Roman','FontSize',8);
        elseif flag==1 
            MovePointersTo(handles,[6 7 4]);
            SetOperationText(handles,'B6 was chosen to be B-encoded based on P7d, instead of P4d...');
            title('Motion vectors - Anchor Frame: P7d, Target Frame: B6','FontName','Times New Roman','FontSize',8);
        end 
        
       
        
        
   case {8}  %%%%%%%%%%%%%%%%%%%%%%% I10 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %%%Show the original I10 frame
        axes(handles.I10Axes); imshow(handles.I10{j}/255); title('I10','FontName','Times New Roman','FontSize',8); drawnow;
       
        axes(handles.I10dAxes); imshow(handles.I10d{j}/255); title(['I10d  - ' num2str(BitsPerSample),' bits/pixel'],'FontName','Times New Roman','FontSize',8); drawnow;
        MovePointersTo(handles,[10 0 0]);
        SetOperationText(handles,'I10 is Intra-Encoded...');
    
        handles.Fig8 = figure('name','I10 Intra Encoding','position',[395,90,560,210]); 
        subplot(1,2,1); imshow(mat2gray(JO)); title('I10: Original 8x8 block DCT coefficients'); set(gca,'FontName','Times New Roman','FontSize',8);
        subplot(1,2,2); imshow(mat2gray(JQ)); title('I10d: Quantized 8x8 block DCT coefficients'); set(gca,'FontName','Times New Roman','FontSize',8);
        
        
   case {9}  %%%%%%%%%%%%%%%%%%%%%%% B8 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         %%%Show the original B8 frame
        axes(handles.B8Axes); imshow(handles.B8{j}/255); title('B8','FontName','Times New Roman','FontSize',8); drawnow;        
        axes(handles.B8dAxes); imshow(handles.B8d{j}/255); title(['B8d - ' num2str(BitsPerSample),' bits/pixel'],'FontName','Times New Roman','FontSize',8); drawnow;
        MotVecY = reshape(MotVec(1,:),size(handles.I1{j})/16); MotVecY=MotVecY';
        MotVecX = reshape(MotVec(2,:),size(handles.I1{j})/16); MotVecX=MotVecX';
        handles.Fig9 = figure('name','B8 B-Encoding','position',[580,74,344,234]);
        h=quiver(MotVecX(end:-1:1,:),-MotVecY(end:-1:1,:),0.5,'k'); set(h,'linewidth',1); set(gca,'xtick',[],'ytick',[]);
        if flag==0 
            MovePointersTo(handles,[8 7 10]);
            SetOperationText(handles,'B8 was chosen to be B-encoded based on P7d, instead of I10d...');
            title('Motion vectors - Anchor Frame: P7d, Target Frame: B8','FontName','Times New Roman','FontSize',8);
        elseif flag==1 
            MovePointersTo(handles,[8 10 7]);
            SetOperationText(handles,'B8 was chosen to be B-encoded based on I10d, instead of P7d...');
            title('Motion vectors - Anchor Frame: I10d, Target Frame: B8','FontName','Times New Roman','FontSize',8);
        end 
        
       
        
   case {10}  %%%%%%%%%%%%%%%%%%%%%%% B9 encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        SetOperationText(handles,'B9 is B-encoded based on P7-decoded or I10-decoded...');
        %%%Show the original B9 frame
        axes(handles.B9Axes); imshow(handles.B9{j}/255); title('B9','FontName','Times New Roman','FontSize',8); drawnow;        
        axes(handles.B9dAxes); imshow(handles.B9d{j}/255); title(['B9d - ' num2str(BitsPerSample),' bits/pixel'],'FontName','Times New Roman','FontSize',8); drawnow;
        MotVecY = reshape(MotVec(1,:),size(handles.I1{j})/16); MotVecY=MotVecY';
        MotVecX = reshape(MotVec(2,:),size(handles.I1{j})/16); MotVecX=MotVecX';
        handles.Fig10 = figure('name','B9 B-Encoding','position',[580,74,344,234]); 
        h=quiver(MotVecX(end:-1:1,:),-MotVecY(end:-1:1,:),0.5,'k'); set(h,'linewidth',1); set(gca,'xtick',[],'ytick',[]);    
        if flag==0 
            MovePointersTo(handles,[9 7 10]);
            SetOperationText(handles,'B9 was chosen to be B-encoded based on P7d, instead of I10d...');
            title('Motion vectors - Anchor Frame: P7d, Target Frame: B9','FontName','Times New Roman','FontSize',8);
        elseif flag==1 
            MovePointersTo(handles,[9 10 7]);
            SetOperationText(handles,'B9 was chosen to be B-encoded based on I10d, instead of P7d...');
            title('Motion vectors - Anchor Frame: I10d, Target Frame: B9','FontName','Times New Roman','FontSize',8);
            
        end 
        
        ConstructEncodedVideo(handles);
        
        
        
end


