function  [V_train,V_test]=pro_cp(X,test_orl)
n=3;
M=khatri_rao(X.core{2},X.core{1});
V_train=X.core{3}';    

kZ_test=test_orl;
kv_test=reshape(permute(kZ_test,[3 1 2]),size(kZ_test,3),[])';
V_test=pinv(M)*kv_test;


end