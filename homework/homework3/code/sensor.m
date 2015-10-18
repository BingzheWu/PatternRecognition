function [a,n]=sensor(w1,w2)
	[n1,m]=size(w1);%获取样本数量及维度
	[n2,m]=size(w2);
    n=0;%迭代次数
	a=zeros(m+1,1);%权向量
	b=[w1 ones(n1,1);-w2 -ones(n2,1)];%统一样本矩阵
    t=1;%错误样本个数，用于判别是否停止迭代
	while t>0 
    %有错分样本则迭代不停止
        t=0;%错误分类样本个数
		sumy=zeros(1,m+1);%储存分类错误的y_i的和
		for i=1:n1+n2
			if b(i,:)*a<=0.2 %如果分类错误，带有余量b=0.2
				sumy=sumy+b(i,:);
                t=t+1;
			end
		end
		a=a+sumy';%迭代更新
		n=n+1;
    end
    
    %作图
    xm=max(abs(b(:,1)));
    x=linspace(-xm,xm,10000);
    y=(a(1)*x+a(3))/(-a(2));
    figure
    plot(x,y);
    hold on
	plot(w1(:,1),w1(:,2),'o',w2(:,1),w2(:,2),'*');
    hold off
end
	