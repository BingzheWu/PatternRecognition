function u1(a)
%��������w1
%����һά

%(a)
%�ֱ�ȡ����������
[n,v]=size(a);
a1=a(:,1);
a2=a(:,2);
a3=a(:,3);

%�ֱ�������������ľ�ֵ�ͷ���
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







    
    