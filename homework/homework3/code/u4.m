function  u4(b)
%(d)
%ÊäÈëÊı¾İw2


[m,v]=size(b);
b1=b(:,1);
b2=b(:,2);
b3=b(:,3);

miub1=(sum(b1))/m;
b10=b1-miub1;
sigemab1=b10'*b10/m;
miub2=(sum(b2))/m;
b20=b2-miub2;
sigemab2=b20'*b20/m;
miub3=(sum(b3))/m;
b30=b3-miub3;
sigemab3=b30'*b30/m;

miub=[miub1 miub2 miub3]
sigemab=[sigemab1 0 0;
    0 sigemab2 0;
    0 0 sigemab3]
	

end

