function [a,n]=sensor(w1,w2)
	[n1,m]=size(w1);%��ȡ����������ά��
	[n2,m]=size(w2);
    n=0;%��������
	a=zeros(m+1,1);%Ȩ����
	b=[w1 ones(n1,1);-w2 -ones(n2,1)];%ͳһ��������
    t=1;%�������������������б��Ƿ�ֹͣ����
	while t>0 
    %�д�������������ֹͣ
        t=0;%���������������
		sumy=zeros(1,m+1);%�����������y_i�ĺ�
		for i=1:n1+n2
			if b(i,:)*a<=0.2 %���������󣬴�������b=0.2
				sumy=sumy+b(i,:);
                t=t+1;
			end
		end
		a=a+sumy';%��������
		n=n+1;
    end
    
    %��ͼ
    xm=max(abs(b(:,1)));
    x=linspace(-xm,xm,10000);
    y=(a(1)*x+a(3))/(-a(2));
    figure
    plot(x,y);
    hold on
	plot(w1(:,1),w1(:,2),'o',w2(:,1),w2(:,2),'*');
    hold off
end
	