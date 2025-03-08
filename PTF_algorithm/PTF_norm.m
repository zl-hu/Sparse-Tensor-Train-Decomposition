function Y=PTF_norm(X_0,problem,kmax)
%����PTF�㷨
%����������������
%����:
%   X_0:��ʼ�㣬�ṹΪX_0.core{1}��X_0.core{2},X_0.core{3}���������CP�ֽ����������
%   problem:���������Ļ�����̬������tensor_size,tensor_rank,tao
%   kamx:����������

%�����
%   Y:Y�����ӵ�0�������һ�������е�����
tensor_size=problem.tensor_size;
tao=problem.tao;
Y{1}=X_0;
X=X_0;


for i=1:kmax
    for j=1
        tao_1=reshape(tao,tensor_size(j),[]);
        M=khatri_rao(X.core{3},X.core{2});
        X.core{j}=X.core{j}.*(tao_1*M)./(X.core{j}*M'*M);
        %ͨ������ƽ��ֵ���й�һ������
        for k=1:3
        y{k}=column_norm(X.core{k}); 
        end
        y_aver=((y{1}.*y{2}.*y{3}).^(1/3));
        X.core{j}=X.core{j}./(y_aver./y{j});
    end
    
    for j=2
        tao_2=reshape(permute(tao,[2 1 3]),tensor_size(j),[]);
        M=khatri_rao(X.core{3},X.core{1});
        X.core{j}=X.core{j}.*(tao_2*M)./(X.core{j}*M'*M);
        %ͨ������ƽ��ֵ���й�һ������
        for k=1:3
        y{k}=column_norm(X.core{k}); 
        end
        y_aver=((y{1}.*y{2}.*y{3}).^(1/3));
        X.core{j}=X.core{j}./(y_aver./y{j});
    end
    
    for j=3
        tao_3=reshape(permute(tao,[3 1 2]),tensor_size(j),[]);
        M=khatri_rao(X.core{2},X.core{1});
        X.core{j}=X.core{j}.*(tao_3*M)./(X.core{j}*M'*M);
        %ͨ������ƽ��ֵ���й�һ������
        for k=1:3
        y{k}=column_norm(X.core{k}); 
        end
        y_aver=((y{1}.*y{2}.*y{3}).^(1/3));
        X.core{j}=X.core{j}./(y_aver./y{j});
    end
    Y{i+1}=X;       
end





end