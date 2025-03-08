function X = prepare(X,problem)
        %为接下来的计算做好准备，新增两个字段:dayu,表示x>=k;xiaoyu,表示x<=k
       tensor_size=problem.tensor_size;
       tensor_rank=problem.tensor_rank;
       n=numel(X.core);
        X.dayu{n+1}=1;
        
        for i=n:-1:1
            X.dayu{i}=kron(X.dayu{i+1},speye(tensor_size(i)))*reshape(X.core{i},tensor_rank(i),[])';
        end
        X.xiaoyu{1}=reshape(X.core{1},[],tensor_rank(2));
   
        for k=2:n
            X.xiaoyu{k}=kron(speye(tensor_size(k)),X.xiaoyu{k-1})*reshape(X.core{k},[],tensor_rank(k+1));
        end
            
end