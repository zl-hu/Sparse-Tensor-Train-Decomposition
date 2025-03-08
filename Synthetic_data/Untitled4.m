%ʵ��һ����������
%��ͬ�ı��ղ���
clear;
clc;
%������ģ��Ŀ����
tensor_size=[10 10 10 10];
tensor_rank=[1 4 4 4 1];
problem.tensor_size=tensor_size;
problem.tensor_rank=tensor_rank;
n=length(tensor_size);

%�趨����
kmax=300;%����������
c_k=1.000001;%�س�����
for k=1:n-1
            [Q,~]=qr(reshape(rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1)),[],tensor_rank(k+1)),0);
            Y_0.core{k}=reshape(Q,tensor_rank(k),tensor_size(k),tensor_rank(k+1));
            %Y_0.core{k}=rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1));
 end
 Y_0.core{n}=rand(tensor_rank(n),tensor_size(n),tensor_rank(n+1));
 tao=whole(Y_0,problem);
 tao=rand(tensor_size);
 problem.tao=tao;

%������Ĳ�����Ϣ������problem��

%��������ĳ�ʼ������
for k=1:n-1
            [Q,~]=qr(reshape(rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1)),[],tensor_rank(k+1)),0);
            X_0.core{k}=reshape(Q,tensor_rank(k),tensor_size(k),tensor_rank(k+1));
 end
 X_0.core{n}=rand(tensor_rank(n),tensor_size(n),tensor_rank(n+1));
% PALM_1
%ע�⣬���muȡ�Ĺ��󣬻ᵼ�����һ����ȫ��0��ʹ��L��0���Ӷ���������
mu=0.01;
problem.mu=mu;



[X_1,err_1]=PALM_safeguard(X_0,problem,c_k,kmax,10);

[X_2,err_2]=PALM_safeguard(X_0,problem,c_k,kmax,3);

[X_3,err_3]=PALM_4(X_0,problem,c_k,kmax);

%%
figure;
semilogy(0:kmax,err_1,'r');
hold on
semilogy(0:kmax,err_2,'b');
semilogy(0:kmax,err_3,'g');
xlabel('Iteration');
ylabel('err');
legend('v=10','v=3','v=1e-16');
%%
figure;
%semilogy(200:kmax,err_1(201:301),'r');
%hold on
semilogy(200:kmax,err_2(201:301),'b');
hold on
semilogy(200:kmax,err_3(201:301),'g');
xlabel('Iteration');
ylabel('err');
legend('v=3','v=1e-16');

