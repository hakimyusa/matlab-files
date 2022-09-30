c(0)
f=ones(8,8)
getdctf(f)
f125=0.125*f
F=getdctf(f125)
finv=getidctf(F)
f0=zeros(8,8)
f01=f0
f01(0,1)=1
f01(1,2)=1
F01=f01
getidct(F01)
getidctf(F01)
[X Y]=meshgrid(8,8)
X
[X Y]=meshgrid(0:7)
surf(X,Y,getidctf(F01))
for x=0:7
z=zeros(8,8)
for x=1:8
for y=1:8
t=z; t(x,y)=1; fm(x,y)=t;
end
end
t
fm(1,1)
t=z; t(x,y)=1; fm{x,y}=t;
z=zeros(8,8);
for x=1:8
for y=1:8
t=z; t(x,y)=1; fm{x,y}=t;
end
end
fm{1,2}

surf(X,Y,getidctf(fm{2,2}))
surf(X,Y,getidctf(fm{1,1}))
surf(X,Y,getidctf(fm{1,2}))
surf(X,Y,getidctf(fm{1,3}))
surf(X,Y,getidctf(fm{1,4}))
surf(X,Y,getidctf(fm{1,5}))
surf(X,Y,getidctf(fm{1,6}))
surf(X,Y,getidctf(fm{1,7}))
surf(X,Y,getidctf(fm{1,8}))
zf1([1 4 5 8],:)=100*ones(4,8)
surf(X,Y,zf1)
surf(X,Y,getdctf(zf1))
getdctf(zf1)
format short e
getdctf(zf1)