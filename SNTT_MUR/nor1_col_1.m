function [Q,R]=nor1_col_1(A)
%ำาน้าปปฏ
a=sum(A);
R=diag(a);
Q=A./a;
end