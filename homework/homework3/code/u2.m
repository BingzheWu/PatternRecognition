function u2(a)
%(b)
%处理二维

%分别取出两个维度的特征
[n,v]=size(a);
a12=a(:,1:1:2);
a23=a(:,2:1:3);
a13=a(:,1:2:3);
I=ones(n,1);

%分别估计均值和协方差矩阵
miua12=(sum(a12))/n
a120=a12-[I*miua12(1) I*miua12(2)];
sigemaa12=a120'*a120/n
miua23=(sum(a23))/n
a230=a23-[I*miua23(1) I*miua23(2)];
sigemaa23=a230'*a230/n
miua13=(sum(a13))/n
a130=a13-[I*miua13(1) I*miua13(2)];
sigemaa13=a130'*a130/n


end

