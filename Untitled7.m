%将所有算法进行识别准确率的比较
%PALM vs PALM_no_orth
clear;
clc;
%tensor rank, tensor size
s1=40;
s2=5;
s3=5;
size_1=28;
size_2=23;
tensor_size=[size_1 size_2 s1*s2];
tensor_rank=[1 20 40 1];
problem.tensor_size=tensor_size;
problem.tensor_rank=tensor_rank;
n=length(tensor_size);

%随机生成训练集与测试集
[train_orl,test_orl]=readfiles_new_2(s1,s2,s3);
 %train_orl=imnoise(train_orl,'gaussian',0,0.05);
 %test_orl=imnoise(test_orl,'gaussian',0,0.05);
%生成相同的初始点

%设定正则化参数

%% STT_PALM
mu=0.01;
kmax=300;%最大迭代步数
problem.tao=train_orl;
c_k=1.000001;%回撤参数
problem.mu=mu;
for k=1:n-1
            [Q,~]=qr(reshape(rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1)),[],tensor_rank(k+1)),0);
            X_0.core{k}=reshape(Q,tensor_rank(k),tensor_size(k),tensor_rank(k+1));
 end
 X_0.core{n}=rand(tensor_rank(n),tensor_size(n),tensor_rank(n+1));
[Y,err_1]=PALM_4(X_0,problem,c_k,kmax);

for i=1:kmax
[V_train,V_test]=pro(Y{i},test_orl,tensor_size,tensor_rank);
rate_1(i)=classify(V_train,V_test,s2,s3);

fprintf('STT-PALM算法第%d次识别准确率为%d\n',i,rate_1(i));
end
%% SNTT_MUR

for k=1:n-1
            G_0.core{k}=rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1));
 end
 G_0.core{n}=rand(tensor_rank(n),tensor_size(n),tensor_rank(n+1));

G=SNTT_MUR_2(G_0,problem,kmax+1);

for i=1:kmax
[V_train,V_test]=pro(G{i},test_orl,tensor_size,tensor_rank);
rate_2(i)=classify(V_train,V_test,s2,s3);
fprintf('SNTT_MUR算法识别准确率为%f\n',rate_2(i));
end




%% NOSTT_PALM
[Y_2,err_2]=PALM_no_orth(X_0,problem,c_k,kmax);

for i=1:kmax
[V_train_2,V_test_2]=pro(Y_2{i},test_orl,tensor_size,tensor_rank);
rate_3(i)=classify(V_train_2,V_test_2,s2,s3);
fprintf('NOSTT-PALM算法第%d次识别准确率为%d\n',i,rate_3(i));
end

%% PTF
R=40;
P_0.core{1}=rand(28,R);
P_0.core{2}=rand(23,R);
P_0.core{3}=rand(200,R);

P=PTF(P_0,problem,kmax);
for i=1:kmax
 [V_train,V_test]=pro_cp(P{i},test_orl);
 rate_4(i)=classify(V_train,V_test,s2,s3);
 
 fprintf('PTF算法第%d次识别准确率为%d\n',i,rate_4(i));
 end



%% 绘图
plot(rate_1,'r')
hold on;
plot(rate_2,'g')
plot(rate_3,'b')
plot(rate_4,'k')
legend('STT-PALM','SNTT-MUR','NOSTT-PALM','PTF')
xlabel('Iteration')
ylabel('Accuracy')
%title('the accuracy for tested algorithms of different algorithms')
