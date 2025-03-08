clear;clc;
%测试NMF_fun的图像识别准确率
s1=40;
s2=5;
s3=5;
[train_orl,test_orl]=readfiles_new_1(s1,s2,s3);

[n,m] = size(train_orl);
r = 40; %reduction dimension

% Initialization
U0 = rand(n,r);
V0 = rand(r,m);
A = train_orl;
E = zeros(size(train_orl));
B = A;

% normalization
UV0 = U0*V0;
U0 = U0 * sqrt(norm(train_orl,'fro'))/sqrt(norm(UV0,'fro'));
V0 = V0 * sqrt(norm(train_orl,'fro'))/sqrt(norm(UV0,'fro'));

fprintf('Initial Error: %.2e\n', norm(train_orl-U0*V0,'fro'));
kmax = 100;
[U_train,V_train,out_train ] = NMF_fun(train_orl, U0, V0, kmax);

for i=1:kmax
V_test{i}=(U_train{i}'*U_train{i})\U_train{i}'*test_orl;
rate(i)=classify(V_train{i},V_test{i},s2,s3);

fprintf('NMF_ANLS算法第%d次识别准确率为%d\n',i,rate(i));
end
hold on
plot(1:kmax,rate,'r')


