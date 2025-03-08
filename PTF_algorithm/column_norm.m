function y=column_norm(A)
%计算矩阵A逐列的F范数
[~,r]=size(A);
for i=1:r
    y(i)=norm(A(:,i),'fro');
end




end