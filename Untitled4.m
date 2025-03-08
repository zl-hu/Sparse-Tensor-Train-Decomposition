%不同的tensor_rank
clear;
clc;
%张量规模，目标秩
s1=40;
s2=5;
s3=5;
size_1=28;
size_2=23;
tensor_size=[size_1 size_2 s1*s2];
tensor_rank{1}=[1 20 20 1];
tensor_rank{2}=[1 20 40 1];
tensor_rank{3}=[1 20 60 1];
problem.tensor_size=tensor_size;
problem.mu=0.01;
n=length(tensor_size);

%随机生成训练集与测试集
[train_orl,test_orl]=readfiles_new_2(s1,s2,s3);


%设定正则化参数
kmax=300;%最大迭代步数
problem.tao=train_orl;

 c_k=1.000001;%回撤参数

for j=1:3
% PALM

problem.tensor_rank=tensor_rank{j};

for k=1:n-1
            [Q,~]=qr(reshape(rand(tensor_rank{j}(k),tensor_size(k),tensor_rank{j}(k+1)),[],tensor_rank{j}(k+1)),0);
            X_0{j}.core{k}=reshape(Q,tensor_rank{j}(k),tensor_size(k),tensor_rank{j}(k+1));
 end
 X_0{j}.core{n}=rand(tensor_rank{j}(n),tensor_size(n),tensor_rank{j}(n+1));
 
 for k=1:n-1
            G_0{j}.core{k}=rand(tensor_rank{j}(k),tensor_size(k),tensor_rank{j}(k+1));
 end
 G_0{j}.core{n}=rand(tensor_rank{j}(n),tensor_size(n),tensor_rank{j}(n+1));


[X,err{j}]=PALM_4(X_0{j},problem,c_k,kmax);
Y.ite{j}=X;

for i=1:kmax+1
[V_train,V_test]=pro(X{i},test_orl,tensor_size,tensor_rank{j});
rate{j}(i)=classify(V_train,V_test,s2,s3);
fprintf('PALM算法第%d次识别准确率为%d\n',i,rate{j}(i));
end


% SNTT_MUR

G=SNTT_MUR_2(G_0{j},problem,kmax+1);
G_1.ite{j}=G;

for i=1:kmax+1
[V_train,V_test]=pro(G{i},test_orl,tensor_size,tensor_rank{j});
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