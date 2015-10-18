function u1(a)
%输入数据w1
%处理一维

%(a)
%分别取出三个特征
[n,v]=size(a);
a1=a(:,1);
a2=a(:,2);
a3=a(:,3);

%分别估计三个特征的均值和方差
miua1=(sum(a1))/n
a10=a1-miua1;
sigemaa1=a10'*a10/n
miua2=(sum(a2))/n
a20=a2-miua2;
sigemaa2=a20'*a20/n
miua3=(sum(a3))/n
a30=a3-miua3;
sigemaa3=a30'*a30/n


end







    
    