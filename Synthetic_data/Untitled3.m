%ʵ��һ����������
%��ͬ��gamma
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
for k=1:n-1
            [Q,~]=qr(reshape(rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1)),[],tensor_rank(k+1)),0);
            Y_0.core{k}=reshape(Q,tensor_rank(k),tensor_size(k),tensor_rank(k+1));
            %Y_0.core{k}=rand(tensor_rank(k),tensor_size(k),tensor_rank(k+1));
 end
 Y_0.core{n}=rand(tensor_rank(n),tensor_size(n),tensor_rank(n+1));
 
 tao=whole(Y_0,problem);
 tao=rand(tensor_size);
 problem.tao=tao;


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

c_k=1.000001;
[X_1,err_1]=PALM_4(X_0,problem,c_k,kmax);

c_k=2;
[X_2,err_2]=PALM_4(X_0,problem,c_k,kmax);

c_k=5;
[X_3,err_3]=PALM_4(X_0,problem,c_k,kmax);

c_k=10;
[X_4,err_4]=PALM_4(X_0,problem,c_k,kmax);



%%
figure;
semilogy(0:kmax,err_1,'r');
hold on
semilogy(0:kmax,err_2,'b');
hold on
semilogy(0:kmax,err_3,'g');
semilogy(0:kmax,err_4,'k')
xlabel('Iteration');
ylabel('err');
legend('\gamma=1.000001','\gamma=2','\gamma=5','\gamma=10');

%%
figure;
semilogy(200:kmax,err_1(201:301),'r');
hold on
semilogy(200:kmax,err_2(201:301),'b');
semilogy(200:kmax,err_3(201:301),'g');
semilogy(200:kmax,err_4(201:301),'k');
xlabel('Iteration');
ylabel('err');
legend('\gamma=1.000001','\gamma=2','\gamma=5','\gamma=10');

