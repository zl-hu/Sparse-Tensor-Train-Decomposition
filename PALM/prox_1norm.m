function z=prox_1norm(x,a)
%һ�������ڽ��ݶ�
%x��ʾͶӰ��
%a��ʾһ����ǰ���ϵ��
%y=abs(x)-a*ones(size(x));
y=abs(x)-a;
y(y<0)=0;
z=y.*sign(x);
end
