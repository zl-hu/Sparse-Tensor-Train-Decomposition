function y=column_norm(A)
%�������A���е�F����
[~,r]=size(A);
for i=1:r
    y(i)=norm(A(:,i),'fro');
end




end