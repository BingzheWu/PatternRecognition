function  p=v3(a,n,x1,x2,x3)
%三维考虑
%取k=3
%使用方窗估计概率密度
%p(x)=k/NV
bb1=a(:,1);
bb2=a(:,2);
bb3=a(:,3);
kk=zeros(1,n);
kk1=[bb1-x1 bb2-x2 bb3-x3];
for j=1:n
    kk(j)=kk1(j,:)*kk1(j,:)';
end
kkk=min(kk);
u=find(kk==kkk);
kk(u(1))=300;
kkk=min(kk);
u=find(kk==kkk);
kk(u(1))=300;
p=3/(4/3*3.1416*(sqrt(min(kk)))^3*n);

end

