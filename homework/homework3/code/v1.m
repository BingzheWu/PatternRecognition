function  v1( aa,n)


%(a)
%ʹ�÷������Ƹ����ܶ�
%p(x)=k/NV

x=linspace(-5,5,10000);
[v,m]=size(x);
y1=double(zeros(1,m));
%���k=1ʱ�ĸ����ܶȺ���
y2=double(zeros(1,m));
%���k=3ʱ�ĸ����ܶȺ���
y3=double(zeros(1,m));
%���k=5ʱ�ĸ����ܶȺ���

for i=1:m
    kk=abs(aa-x(i));
    kkk=min(kk);
    y1(i)=1/(2*kkk*n);
    u=find(kk==kkk);
    kk(u(1))=10;
    kkk=min(kk);
    u=find(kk==kkk);
    kk(u(1))=10;
    kkk=min(kk);
    y2(i)=3/(2*kkk*n);
    u=find(kk==kkk);
    kk(u(1))=10;
    kkk=min(kk);
    u=find(kk==kkk);
    kk(u(1))=10;
    kkk=min(kk);
    y3(i)=5/(2*kkk*n);
end

figure
plot(x,y1)
title('k=1');
figure
plot(x,y2)
title('k=3');
figure
plot(x,y3)
title('k=5');


end

