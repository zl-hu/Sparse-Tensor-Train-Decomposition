clear;clc;
%PALM
load('mnist.mat');
%������ģ��Ŀ����
n_1=1000;
n_2=200;
train_data=trainImages(:,:,1:n_1);
test_data=testImages(:,:,1:n_2);
train_label=trainLabels(1:n_1,1);
test_label=testLabels(1:n_2,1);


tensor_size=size(train_data);
tensor_rank=[1 28 100 1];
problem.tensor_size=tensor_size;
problem.tensor_rank=tensor_rank;
n=length(tensor_size);

%������ͬ�ĳ�ʼ��
j=1;
for k=1:n-1
            [Q,~]=qr(reshape(rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1)),[],tensor_rank(k+1)),0);
            X_0.core{k}=reshape(Q,tensor_rank(k),tensor_size(k),tensor_rank(k+1));
 end
 X_0.core{n}=rand(tensor_rank(n),tensor_size(n),tensor_rank(n+1));
%�趨���򻯲���
mu=0.01;
kmax=300;%����������

problem.tao=train_data;

c_k=1.000001;%�س�����
%������Ĳ�����Ϣ������problem��
problem.mu=mu;

% test_data=test_data(:,:,1:30);
% test_label=test_label(1:30,1);
%% STT_PALM


%[Y,err]=PALM_4(X_0,problem,c_k,kmax);
Y=PALM_3(X_0,problem,c_k,kmax);
for i=1:kmax
[V_train,V_test]=pro(Y{i},test_data,tensor_size,tensor_rank);
rate(i)=classify_label(V_train,V_test,train_label,test_label);
fprintf('PALM�㷨��%d��ʶ��׼ȷ��Ϊ%d\n',i,rate(i));
end
% for i=1:kmax                                                      
% [V_train,V_test]=pro(Y{i},test_orl,tensor_size,tensor_rank);
% rate(i)=classify(V_train,V_test,s2,s3);
% 
% fprintf('PALM�㷨��%d��ʶ��׼ȷ��Ϊ%d\n',i,rate(i));
% end

 

%% SNTT_MUR
for k=1:n-1
            G_0.core{k}=rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1));
 end
 G_0.core{n}=rand(tensor_rank(n),tensor_size(n),tensor_rank(n+1));

G=SNTT_MUR_2(G_0,problem,kmax+1);

for i=1:kmax
[V_train,V_test]=pro(G{i},test_data,tensor_size,tensor_rank);
rate_2(i)=classify_label(V_train,V_test,train_label,test_label);
fprintf('SNTT_MUR�㷨��%d��ʶ��׼ȷ��Ϊ%f\n',i,rate_2(i));
end

%% ��ͼ
plot(rate,'r')
hold on;
plot(rate_2,'b')
legend('STT-PALM','SNTT-MUR')
xlabel('Iteration')
ylabel('Accuracy')
