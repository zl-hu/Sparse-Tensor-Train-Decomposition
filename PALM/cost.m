function f=cost(X,problem)
%计算目标函数
%需要为它添加正则化参数
n=numel(X.core);
mu=problem.mu;
f=0.5*norm(reshape(touying(X,problem),[],1),'fro')^2+mu*norm(reshape(X.core{n},[],1),1);
%注意：这里写1范数的时候，要把它变成向量，不然它返回的就是最大列的1范数；




end