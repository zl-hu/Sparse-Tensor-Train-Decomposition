function tau=whole(X,problem)
tensor_size=problem.tensor_size;
tensor_rank=problem.tensor_rank;
n=numel(X.core);
xiaoyu{1}=reshape(X.core{1},[],tensor_rank(2));
    for k=2:n
            xiaoyu{k}=kron(speye(tensor_size(k)),xiaoyu{k-1})*reshape(X.core{k},[],tensor_rank(k+1));
    end
    tau=reshape(xiaoyu{n},tensor_size);
end