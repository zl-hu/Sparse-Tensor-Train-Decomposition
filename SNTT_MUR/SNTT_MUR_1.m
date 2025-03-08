function G=SNTT_MUR_1(G_0,problem,kmax)
%change log:��������ģʽ����
%input:X_0,��ʼ������;problem,������Ϣ������problem.tensor_size,problem.tensor_rank,problem.mu;kmax;����������
%output:X_1���㷨���ɵ���ֵ;f_1,����ֵ
tensor_size=problem.tensor_size;
tensor_rank=problem.tensor_rank;
tao=problem.tao;
mu=problem.mu;
%���ɳ�ʼ������
n=numel(G_0.core);

a=reshape(tao,[],1);

G{1}=G_0;


for k=2:kmax
    
    i=1;
    G{k}=nor1_tensor_1(G{k-1},tensor_rank);
    G{k}=prepare(G{k},problem);
    
    A=double(ttm(tensor(reshape(tao,1,tensor_size(i),[])),G{k}.dayu{2}',3));
    B=double(ttm(tensor(G{k}.core{i}),{G{k}.dayu{2}'*G{k}.dayu{2}},3));
    g{1}=G{k}.core{1}.*A./(B+mu);
    [Q{i},R{i}]=nor1_col_1(reshape(g{1},[],tensor_rank(2)));
    G{k}.core{i}=reshape(Q{i},tensor_rank(i),[],tensor_rank(i+1));
    G{k}.core{i+1}=double(ttm(tensor(G{k}.core{i+1}),R{i},1));
    
    for i=2:n-1
        G{k}=prepare(G{k},problem);
        A=double(ttm(tensor(reshape(tao,prod(tensor_size(1:i-1)),tensor_size(i),[])),{G{k}.xiaoyu{i-1}' G{k}.dayu{i+1}'},[1 3]));
        B=double(ttm(tensor(G{k}.core{i}),{G{k}.xiaoyu{i-1}'*G{k}.xiaoyu{i-1} G{k}.dayu{i+1}'*G{k}.dayu{i+1}},[1 3]));
        g{i}=G{k}.core{i}.*A./(B+mu);
        
        [Q{i},R{i}]=nor1_col_1(reshape(g{i},[],tensor_rank(i+1)));
        G{k}.core{i}=reshape(Q{i},tensor_rank(i),[],tensor_rank(i+1));
        G{k}.core{i+1}=double(ttm(tensor(G{k}.core{i+1}),R{i},1));
    end
    
    i=n;
    G{k}=prepare(G{k},problem);
    A=double(ttm(tensor(reshape(tao,prod(tensor_size(1:i-1)),tensor_size(i),[])),{G{k}.xiaoyu{i-1}'},1));
     B=double(ttm(tensor(G{k}.core{i}),{G{k}.xiaoyu{i-1}'*G{k}.xiaoyu{i-1}},1));
    G{k}.core{i}=G{k}.core{i}.*A./(B+mu);
    
    k
end



end