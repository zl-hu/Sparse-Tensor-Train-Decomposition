function G_1=nor1_tensor_1(G,tensor_rank)
%将所有的核左归一化到第一个核
n=numel(G.core);
[G_1.core{n},R{n}]=nor1_row_1(G.core{n});

for i=n-1:2
    G_2{i}=double(ttm(tensor(G.core{i}),R{i+1}',3));
    [G_3.core{i},R{i}]=nor1_row_1(reshape(G_2{i},tensor_rank(i),[]));
    G_1.core{i}=reshape(G_3.core{i},tensor_rank(i),[],tensor_rank(i+1));
end
G_1.core{1}=double(ttm(tensor(G.core{1}),R{2}',3));




end