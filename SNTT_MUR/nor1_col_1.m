function [Q,R]=nor1_col_1(A)
%�ҹ�һ��
a=sum(A);
R=diag(a);
Q=A./a;
end