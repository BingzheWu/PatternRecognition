function [a,n]=lms2(w1,w2)
    [n1,m]=size(w1);
    [n2,m]=size(w2); %��ȡ��С
    Y=[w1 ones(n1,1);
        -w2 -ones(n2,1)]; %��������Ϊ��������
    n=0; %��������
    a0=2*ones(m+1,1); 
    a=rand(m+1,1); %��ʼ��
    while ((a-a0)'*(a-a0)>0.0001)&&(n<1000)
    %���ε�a�ܽӽ�ʱֹͣ����
        a0=a;
        n=n+1;
        for i=1:n1+n2
            if Y(i,:)*a~=1
                a=a+(1-Y(i,:)*a)*Y(i,:)'/2;
                %����������
                break;
            end
        end
    end
    %��ͼ
    xm=max(abs(Y(:,1)));
    x=linspace(-xm,xm,10000);
    y=(a(1)*x+a(3))/(-a(2));
    figure
    plot(x,y);
    hold on
	plot(w1(:,1),w1(:,2),'o',w2(:,1),w2(:,2),'*');
    hold off
end

