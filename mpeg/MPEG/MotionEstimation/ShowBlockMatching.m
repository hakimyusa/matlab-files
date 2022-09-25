function ShowBlockMatching(im1,im2,handles)

OperationOnTheFly(true,handles);

%%%The size of frame:
Ny=size(im1,1); Nx=size(im1,2);

%%%Parameters for the block matching algorithm
val = get(handles.BlockSizePopup,'value');
if (val==1)
    bsize=16; 
elseif (val==2)
    bsize=8;
end

val = get(handles.SearchRangePopup,'value');
srange=val-1;

val = get(handles.SearchAccuracyPopup,'value');
if (val==1)
    halfPel=false;
elseif (val==2)
    halfPel=true;
end


if (halfPel==false)
    [mvy,mvx,pimg]=EBMA(im1, im2, bsize, srange, srange);
else
    [mvy,mvx,pimg]=EBMA_half(im1, im2, bsize, srange, srange); 
end


[X,Y]=meshgrid(linspace(bsize/2,Nx,size(mvy,2)),linspace(bsize/2,Ny,size(mvy,1)) );
axes(handles.MVAxes);
h=quiver(X,Y,5*mvx(end:-1:1,:),-5*mvy(end:-1:1,:)); 
set(h,'color','k');
axis([0 Nx 0 Ny]);
axis off;
axis equal;

%%%%%%%%%This is for problems of not equal size between im2 and pimg
pimg1 = pimg;
pimg = im2;
pimg(1:size(pimg1,1),1:size(pimg1,2))=pimg1;



%%% Show the predicted image
axes(handles.PredictedFrameAxes);
imshow(pimg);


%%% Show the Prediction Error image
axes(handles.ErrorAxes);
errorImage = im2-pimg;
imshow(errorImage,[-1 1]);


%%%%Show various results
MAE = mean(mean(abs(errorImage)));
set(handles.BlockMatchingMAEEdit,'string',num2str(MAE));


MSE = mean(mean(errorImage.^2)); PSNR = -10*log10(MSE);
set(handles.BlockMatchingPSNREdit,'string',num2str(PSNR));


set(handles.NumOfMVsEdit,'string',num2str(numel(mvx)));

OperationOnTheFly(false,handles);
