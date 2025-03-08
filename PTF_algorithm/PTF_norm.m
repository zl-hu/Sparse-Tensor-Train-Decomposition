function Y=PTF_norm(X_0,problem,kmax)
%对于PTF算法
%仅适用于三阶张量
%输入:
%   X_0:初始点，结构为X_0.core{1}，X_0.core{2},X_0.core{3}，代表组成CP分解的三个矩阵
%   problem:包含张量的基本心态，包括tensor_size,tensor_rank,tao
%   kamx:最大迭代步数

%输出：
%   Y:Y包含从第0步到最后一步的所有迭代点
tensor_size=problem.tensor_size;
tao=problem.tao;
Y{1}=X_0;
X=X_0;


for i=1:kmax
    for j=1
        tao_1=reshape(tao,tensor_size(j),[]);
        M=khatri_rao(X.core{3},X.core{2});
        X.core{j}=X.core{j}.*(tao_1*M)./(X.core{j}*M'*M);
        %通过几何平均值进行归一化处理
        for k=1:3
        y{k}=column_norm(X.core{k}); 
        end
        y_aver=((y{1}.*y{2}.*y{3}).^(1/3));
        X.core{j}=X.core{j}./(y_aver./y{j});
    end
    
    for j=2
        tao_2=reshape(permute(tao,[2 1 3]),tensor_size(j),[]);
        M=khatri_rao(X.core{3},X.core{1});
        X.core{j}=X.core{j}.*(tao_2*M)./(X.core{j}*M'*M);
        %通过几何平均值进行归一化处理
        for k=1:3
        y{k}=column_norm(X.core{k}); 
        end
        y_aver=((y{1}.*y{2}.*y{3}).^(1/3));
        X.core{j}=X.core{j}./(y_aver./y{j});
    end
    
    for j=3
        tao_3=reshape(permute(tao,[3 1 2]),tensor_size(j),[]);
        M=khatri_rao(X.core{2},X.core{1});
        X.core{j}=X.core{j}.*(tao_3*M)./(X.core{j}*M'*M);
        %通过几何平均值进行归一化处理
        for k=1:3
        y{k}=column_norm(X.core{k}); 
        end
        y_aver=((y{1}.*y{2}.*y{3}).^(1/3));
        X.core{j}=X.core{j}./(y_aver./y{j});
    end
    Y{i+1}=X;       
end





end