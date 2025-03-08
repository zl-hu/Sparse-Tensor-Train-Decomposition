function [Y,err]=PALM_no_orth(X_0,problem,c_k,kmax)
%求解稀疏张量分解问题
%对前d-1个核不施加正交约束
X_1{1}=X_0;
tensor_size=problem.tensor_size;
tensor_rank=problem.tensor_rank;
n=length(tensor_size);
mu=problem.mu;
Y{1}=X_0;
for j=1:kmax
    %f_1(j)=cost(X_1{j},problem);
    %fprintf('PALM第%d次迭代的函数值是%d\n',j,f_1(j));
    err(j)=norm(reshape(touying(Y{j},problem),[],1),'fro')^2/norm(reshape(problem.tao,[],1),'fro')^2;

    k=1;
    da{n+1}=1;
    for i=n:-1:2
        da{i}=kron(da{i+1},eye(tensor_size(i)))*reshape(X_1{k}.core{i},tensor_rank(i),[])';
    end
    
    L=max(norm(da{k+1},'fro')^2,1e-16);
    alpha=1/(L*c_k);
    eta{1}=-double(ttm(tensor(reshape(touying(X_1{j},problem),1,tensor_size(k),[])),da{2}',3));
     X_1{j}.core{k}=X_1{j}.core{k}+alpha*eta{1};

    
    for k=2:n-1
        for i=n:-1:k+1
        da{i}=kron(da{i+1},eye(tensor_size(i)))*reshape(X_1{j}.core{i},tensor_rank(i),[])';
        end        
         xiao{1}=reshape(X_1{j}.core{1},[],tensor_rank(2));
        if k-1>=2
        for i=2:k-1
            xiao{i}=kron(eye(tensor_size(i)),xiao{i-1})*reshape(X_1{j}.core{i},[],tensor_rank(i+1));
        end
        end
       L=max(norm(da{k+1},'fro')^2,1e-16);
    alpha=1/(L*c_k);
    
    eta{k}=-double(ttm(tensor(reshape(touying(X_1{j},problem),prod(tensor_size(1:k-1)),tensor_size(k),[])),{xiao{k-1}' da{k+1}'},[1 3]));
        X_1{j}.core{k}=X_1{j}.core{k}+alpha*eta{k};
     end
     
    k=n;
    xiao{1}=reshape(X_1{j}.core{1},[],tensor_rank(2));
    for i=2:k-1
            xiao{i}=kron(eye(tensor_size(i)),xiao{i-1})*reshape(X_1{j}.core{i},[],tensor_rank(i+1));
    end  
        
    eta{k}=double(ttm(tensor(reshape(touying(X_1{j},problem),prod(tensor_size(1:k-1)),tensor_size(k),[])),{xiao{k-1}'},1));
    L=1;
    alpha=1/(L*c_k);
    X_1{j}.core{k}=prox_1norm(X_1{j}.core{k}-alpha*eta{k},mu*alpha); 
    Y{j+1}=X_1{j};
    X_1{j+1}=X_1{j};
    %j
end

err(kmax+1)=norm(reshape(touying(Y{kmax+1},problem),[],1),'fro')^2/norm(reshape(problem.tao,[],1),'fro')^2;

end