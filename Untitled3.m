
clear;
clc;
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

[train_orl,test_orl]=readfiles_new_2(s1,s2,s3);
%train_orl=imnoise(train_orl,'gaussian',0,0.05);
%test_orl=imnoise(test_orl,'gaussian',0,0.05);

kmax=300;%�?��迭代步数
problem.tao=train_orl;
mu=[0.1 0.01 0.001];
for k=1:n-1
            [Q,~]=qr(reshape(rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1)),[],tensor_rank(k+1)),0);
            X_0.core{k}=reshape(Q,tensor_rank(k),tensor_size(k),tensor_rank(k+1));
 end
 X_0.core{n}=rand(tensor_rank(n),tensor_size(n),tensor_rank(n+1));
 
 for k=1:n-1
            G_0.core{k}=rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1));
 end
 G_0.core{n}=rand(tensor_rank(n),tensor_size(n),tensor_rank(n+1));
 c_k=1.000001;%回撤参数

for j=1:3
% PALM

problem.mu=mu(j);

[X,err{j}]=PALM_4(X_0,problem,c_k,kmax);
Y.ite{j}=X;

for i=1:kmax+1
[V_train,V_test]=pro(X{i},test_orl,tensor_size,tensor_rank);
rate{j}(i)=classify(V_train,V_test,s2,s3);
fprintf('PALM算法�?d次识别准确率�?d\n',i,rate{j}(i));
end


% SNTT_MUR

G=SNTT_MUR_2(G_0,problem,kmax+1);
G_1.ite{j}=G;

for i=1:kmax+1
[V_train,V_test]=pro(G{i},test_orl,tensor_size,tensor_rank);
rate1{j}(i)=classify(V_train,V_test,s2,s3);
fprintf('SNTT_MUR算法识别准确率为%f\n',rate1{j}(i));
end

end

for j=1:3
    figure(j)
plot(0:kmax,rate{j},'r')
hold on;
plot(0:kmax,rate1{j},'b')
legend('STT-PALM','SNTT-MUR')
xlabel('Iteration')
ylabel('Accuracy')

end
% 

%title('he relative error for tested algorithms of different algorithms')
