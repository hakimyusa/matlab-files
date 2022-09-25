function m=deRunLength(X,B,array,MatAC,MatDC)
DC = dcDecode(X,MatDC);
baseLayer=acDecode(B,MatAC);

Layer=mergeLayer(DC,baseLayer);
m = inverseDCT(Layer,array);