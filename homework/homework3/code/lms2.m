function [a,n]=lms2(w1,w2)
    [n1,m]=size(w1);
    [n2,m]=size(w2); %获取大小
    Y=[w1 ones(n1,1);
        -w2 -ones(n2,1)]; %整理样本为增广样本
    n=0; %迭代次数
    a0=2*ones(m+1,1); 
    a=rand(m+1,1); %初始化
    while ((a-a0)'*(a-a0)>0.0001)&&(n<1000)
    %两次的a很接近时停止迭代
        a0=a;
        n=n+1;
        for i=1:n1+n2
            if Y(i,:)*a~=1
                a=a+(1-Y(i,:)*a)*Y(i,:)'/2;
                %单样本修正
                break;
            end
        end
    end
    %作图
    xm=max(abs(Y(:,1)));
    x=linspace(-xm,xm,10000);
    y=(a(1)*x+a(3))/(-a(2));
    figure
    plot(x,y);
    hold on
	plot(w1(:,1),w1(:,2),'o',w2(:,1),w2(:,2),'*');
    hold off
end

