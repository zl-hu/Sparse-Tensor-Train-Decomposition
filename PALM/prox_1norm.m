function z=prox_1norm(x,a)
%一范数的邻近梯度
%x表示投影点
%a表示一范数前面的系数
%y=abs(x)-a*ones(size(x));
y=abs(x)-a;
y(y<0)=0;
z=y.*sign(x);
end
