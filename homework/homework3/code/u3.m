function u3(a)
%(c)
%处理三维
%对三维特征估计均值和方差
[n,v]=size(a);
I=ones(n,1);
miua=(sum(a))/n
a0=a-[I*miua(1) I*miua(2) I*miua(3)];
sigemaa=a0'*a0/n


end

