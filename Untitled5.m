%不同的训练集数量
clear;
clc;
%张量规模，目标秩
s1=40;
s2{1}=3;
s3{1}=7;

s2{2}=5;
s3{2}=5;

s2{3}=7;
s3{3}=3;

size_1=28;
size_2=23;
tensor_rank=[1 20 40 1];
problem.tensor_rank=tensor_rank;
 c_k=1.000001;%回撤参数
 problem.mu=0.01;

 kmax=300;%最大迭代步数

for j=1:3
% PALM
tensor_size{j}=[size_1 size_2 s1*s2{j}];
problem.tensor_size=tensor_size{j};


[train_orl{j},test_orl{j}]=readfiles_new_2(s1,s2{j},s3{j});
problem.tao=train_orl{j};







 n=length(tensor_size{j});
for k=1:n-1
            [Q,~]=qr(reshape(rand(tensor_rank(k),tensor_size{j}(k),tensor_rank(k+1)),[],tensor_rank(k+1)),0);
            X_0{j}.core{k}=reshape(Q,tensor_rank(k),tensor_size{j}(k),tensor_rank(k+1));
 end
 X_0{j}.core{n}=rand(tensor_rank(n),tensor_size{j}(n),tensor_rank(n+1));
 
 for k=1:n-1
            G_0{j}.core{k}=rand(tensor_rank(k),tensor_size{j}(k),tensor_rank(k+1));
 end
 G_0{j}.core{n}=rand(tensor_rank(n),tensor_size{j}(n),tensor_rank(n+1));


[X,err{j}]=PALM_4(X_0{j},problem,c_k,kmax);
Y.ite{j}=X;

for i=1:kmax+1
[V_train,V_test]=pro(X{i},test_orl{j},tensor_size{j},tensor_rank);
rate{j}(i)=classify(V_train,V_test,s2{j},s3{j});
fprintf('PALM算法第%d次识别准确率为%d\n',i,rate{j}(i));
end


% SNTT_MUR

G=SNTT_MUR_2(G_0{j},problem,kmax+1);
G_1.ite{j}=G;

for i=1:kmax+1
[V_train,V_test]=pro(G{i},test_orl{j},tensor_size{j},tensor_rank);
rate1{j}(i)=classify(V_train,V_test,s2{j},s3{j});
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