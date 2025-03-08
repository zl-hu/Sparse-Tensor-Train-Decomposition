function [Y,alph,f_1]=PALM_2(X_0,problem,c_k,kmax)
X_1{1}=X_0;
tensor_size=problem.tensor_size;
tensor_rank=problem.tensor_rank;
n=length(tensor_size);
mu=problem.mu;
Y{1}=X_0
for j=1:kmax
    f_1(j)=cost(X_1{j},problem);
    fprintf('PALM第%d次迭代的函数值是%d\n',j,f_1(j));
    
    
    k=1;
    X_1{j}=prepare(X_1{j},problem);
    L{j,k}=norm(X_1{j}.dayu{k+1},'fro')^2;
    alpha=1/(L{j,k}*c_k);
    eta{1}=-reshape(reshape(touying(X_1{j},problem),tensor_size(1),[])*X_1{j}.dayu{2},tensor_rank(1),tensor_size(1),tensor_rank(2));
    s=reshape(X_1{j}.core{k}+alpha*eta{1},[],tensor_rank(2));
    [U,S,V]=svd(s','econ');
     alph(j,k)=alpha;
     X_1{j}.core{k}=reshape(V*U',tensor_rank(1),tensor_size(1),tensor_rank(2));

    
    for k=2:n-1
        X_1{j}=prepare(X_1{j},problem);
       L{j,k}=norm(X_1{j}.dayu{k+1},'fro')^2;
    alpha=1/(L{j,k}*c_k);
        eta{k}=-reshape(kron(eye(tensor_size(k)),X_1{j}.xiaoyu{k-1}')*reshape(touying(X_1{j},problem),prod(tensor_size(1:k)),[])*X_1{j}.dayu{k+1},tensor_rank(k),tensor_size(k),tensor_rank(k+1));
         s=reshape(X_1{j}.core{k}+alpha*eta{k},[],tensor_rank(k+1));
    [U,S,V]=svd(s','econ');
         alph(j,k)=alpha;
        X_1{j}.core{k}=reshape(V*U',tensor_rank(k),tensor_size(k),tensor_rank(k+1));
     end
     
    k=n;
    X_1{j}=prepare(X_1{j},problem);
    eta{k}=reshape(kron(speye(tensor_size(k)),X_1{j}.xiaoyu{k-1}')*reshape(touying(X_1{j},problem),prod(tensor_size(1:k)),[])*X_1{j}.dayu{k+1},tensor_rank(k),tensor_size(k),tensor_rank(k+1));     
     %回溯步长
          L{j,k}=norm(X_1{j}.dayu{k+1},'fro')^2;
    alpha=1/(L{j,k}*c_k);
    X_1{j}.core{k}=prox_1norm(X_1{j}.core{k}-alpha*eta{k},mu*alpha); 
    alph(j,k)=alpha;
    Y{j+1}=X_1{j};
    X_1{j+1}=X_1{j};

end