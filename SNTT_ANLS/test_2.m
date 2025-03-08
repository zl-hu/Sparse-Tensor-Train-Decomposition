clear;clc;
s1=40;
s2=5;
s3=5;
[train_orl,test_orl]=readfiles_new_2(s1,s2,s3);
tensor_size=size(train_orl);
tensor_rank=[1 20 20 1];
itemax=5;
rtol=1e-3;
type='NNRALS'
lambda=0.01;
%varargin
[X,x, err]=NTT_RALS_1(train_orl, tensor_rank, itemax, rtol,lambda )
Y.core=x

%进行图片分类
[V_train,V_test]=pro(X{1},test_orl,tensor_size,tensor_rank)
rate=classify(V_train,V_test,s2,s3)