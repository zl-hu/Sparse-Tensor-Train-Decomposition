%ʵ��һ����������
%��ͬ��mu
clear;
clc;
%������ģ��Ŀ����
tensor_size=[10 10 10 10];
problem.tensor_size=tensor_size;

n=length(tensor_size);

tensor_rank=[1 4 4 2 1];
problem.tensor_rank=tensor_rank;
%�趨����
kmax=300;%����������
c_k=1.000001;%�س�����
for k=1:n-1
            [Q,~]=qr(reshape(rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1)),[],tensor_rank(k+1)),0);
            Y_0.core{k}=reshape(Q,tensor_rank(k),tensor_size(k),tensor_rank(k+1));
 end
 Y_0.core{n}=rand(tensor_rank(n),tensor_size(n),tensor_rank(n+1));
 tao=whole(Y_0,problem);
 %tao=randn(tensor_size);
 problem.tao=tao;

%������Ĳ�����Ϣ������problem��
tensor_rank=[1 4 4 9 1];
problem.tensor_rank=tensor_rank;
%��������ĳ�ʼ������
for k=1:n-1
            [Q,~]=qr(reshape(rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1)),[],tensor_rank(k+1)),0);
            X_0.core{k}=reshape(Q,tensor_rank(k),tensor_size(k),tensor_rank(k+1));
 end
 X_0.core{n}=rand(tensor_rank(n),tensor_size(n),tensor_rank(n+1));
% PALM_1
%ע�⣬���muȡ�Ĺ��󣬻ᵼ�����һ����ȫ��0��ʹ��L��0���Ӷ���������
mu=0.1;
problem.mu=mu;
[X_1,err_1]=PALM_4(X_0,problem,c_k,kmax);

mu=0.01;
problem.mu=mu;
[X_2,err_2]=PALM_4(X_0,problem,c_k,kmax);

mu=0;
problem.mu=mu;
[X_3,err_3]=PALM_4(X_0,problem,c_k,kmax);


%%
figure;
semilogy(0:kmax,err_1,'r');
hold on
semilogy(0:kmax,err_2,'b');
semilogy(0:kmax,err_3,'g');
xlabel('Iteration');
ylabel('err');
legend('\mu=0.1','\mu=0.01','\mu=0');
%%
figure;
semilogy(100:300,err_1(100:300),'r');
hold on
semilogy(100:300,err_2(100:300),'b');
semilogy(100:300,err_3(100:300),'g');
xlabel('Iteration');
ylabel('err');                  
legend('\mu=0.1','\mu=0.01','\mu=0');


