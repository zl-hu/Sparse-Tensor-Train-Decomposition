function G=SNTT_MUR_2(G_0,problem,kmax)
%change log:采用张量模式更新
%不用计算所有核的大于小于，只计算相邻的即可
%input:X_0,初始迭代点;problem,问题信息，包括problem.tensor_size,problem.tensor_rank,problem.mu;kmax;最大迭代步数
%output:X_1，算法生成点列值;f_1,序列值
tensor_size=problem.tensor_size;
tensor_rank=problem.tensor_rank;
tao=problem.tao;
mu=problem.mu;
%生成初始迭代点
n=numel(G_0.core);

a=reshape(tao,[],1);

G{1}=G_0;


for k=2:kmax
    
    i=1;
    G{k}=nor1_tensor_1(G{k-1},tensor_rank);
   da{n+1}=1;
    for j=n:-1:2
        da{j}=kron(da{j+1},speye(tensor_size(j)))*reshape(G{k}.core{j},tensor_rank(j),[])';
    end
    
    A=double(ttm(tensor(reshape(tao,1,tensor_size(i),[])),da{2}',3));
    B=double(ttm(tensor(G{k}.core{i}),{da{2}'*da{2}},3));
    [Q{i},R{i}]=nor1_col_1(reshape(G{k}.core{1}.*A./(B+mu),[],tensor_rank(2)));
    G{k}.core{i}=reshape(Q{i},tensor_rank(i),[],tensor_rank(i+1));
    G{k}.core{i+1}=double(ttm(tensor(G{k}.core{i+1}),R{i},1));
    
    for i=2:n-1
        for j=n:-1:i+1
        da{j}=kron(da{j+1},speye(tensor_size(j)))*reshape(G{k}.core{j},tensor_rank(j),[])';
        end
        
         xiao{1}=reshape(G{k}.core{1},[],tensor_rank(2));
        if i-1>=2
        for j=2:i-1
            xiao{j}=kron(speye(tensor_size(j)),xiao{j-1})*reshape(G{k}.core{j},[],tensor_rank(j+1));
        end
        end
        
        
        A=double(ttm(tensor(reshape(tao,prod(tensor_size(1:i-1)),tensor_size(i),[])),{xiao{i-1}' da{i+1}'},[1 3]));
        B=double(ttm(tensor(G{k}.core{i}),{xiao{i-1}'*xiao{i-1} da{i+1}'*da{i+1}},[1 3]));
        [Q{i},R{i}]=nor1_col_1(reshape(G{k}.core{i}.*A./(B+mu),[],tensor_rank(i+1)));
        G{k}.core{i}=reshape(Q{i},tensor_rank(i),[],tensor_rank(i+1));
        G{k}.core{i+1}=double(ttm(tensor(G{k}.core{i+1}),R{i},1));
    end
    
    i=n;
    xiao{1}=reshape(G{k}.core{1},[],tensor_rank(2));
    for j=2:i-1
            xiao{j}=kron(speye(tensor_size(j)),xiao{j-1})*reshape(G{k}.core{j},[],tensor_rank(j+1));
    end  
    A=double(ttm(tensor(reshape(tao,prod(tensor_size(1:i-1)),tensor_size(i),[])),{xiao{i-1}'},1));
     B=double(ttm(tensor(G{k}.core{i}),{xiao{i-1}'*xiao{i-1}},1));
    G{k}.core{i}=G{k}.core{i}.*A./(B+mu);
    
end



end