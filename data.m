buka = xlsread('data.xlsx');
x = buka(:,1);
y = buka(:,2);
bar(x,y);