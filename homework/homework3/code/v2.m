function  v2( bb ,n)
%(b)
%使用方窗估计概率密度
%p(x)=k/NV
xx=linspace(-5,5,1000);
yy=linspace(-5,5,1000);
[v,m1]=size(xx);
[v,m2]=size(yy);
z1=zeros(m1,m2);
%存放k=1时的概率密度函数
z2=zeros(m1,m2);
%存放k=3时的概率密度函数
z3=zeros(m1,m2);
%存放k=5时的概率密度函数
bb1=bb(:,1);
bb2=bb(:,2);
kk=zeros(1,n);
for i1=1:m1
    for i2=1:m2
        kk1=[bb1-xx(i1) bb2-yy(i2)];
        for j=1:n
            kk(j)=kk1(j,:)*kk1(j,:)';
        end
        kkk=min(kk);
        z1(i1,i2)=1/(3.1416*kkk*n);
        u=find(kk==kkk);
        kk(u(1))=200;
        kkk=min(kk);
        u=find(kk==kkk);
        kk(u(1))=200;
        kkk=min(kk);
        z2(i1,i2)=3/(3.1416*kkk^2*n);
        u=find(kk==kkk);
        kk(u(1))=200;
        kkk=min(kk);
        u=find(kk==kkk);
        kk(u(1))=200;
        kkk=min(min(kk));
        z3(i1,i2)=5/(3.1416*kkk^2*n);
    end
end

figure
mesh(xx,yy,z1)
title('k=1');
figure
mesh(xx,yy,z2)
title('k=3');
figure
mesh(xx,yy,z3)
title('k=5');


end

