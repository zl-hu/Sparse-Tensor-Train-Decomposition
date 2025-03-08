function  [V_train,V_test]=pro(X,test_orl,tensor_size,tensor_rank)
n=3;
 X.dayu{n+1}=1; 
        for i=n:-1:1
            X.dayu{i}=kron(X.dayu{i+1},speye(tensor_size(i)))*reshape(X.core{i},tensor_rank(i),[])';
        end
        X.xiaoyu{1}=reshape(X.core{1},[],tensor_rank(2));
   
        for k=2:n
            X.xiaoyu{k}=kron(speye(tensor_size(k)),X.xiaoyu{k-1})*reshape(X.core{k},[],tensor_rank(k+1));
        end

kZ_test=test_orl;
kv_test=reshape(kZ_test,[],size(kZ_test,3));
V_test=pinv(X.xiaoyu{2})*kv_test;
V_train= X.dayu{3}';    

end