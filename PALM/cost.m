function f=cost(X,problem)
%����Ŀ�꺯��
%��ҪΪ��������򻯲���
n=numel(X.core);
mu=problem.mu;
f=0.5*norm(reshape(touying(X,problem),[],1),'fro')^2+mu*norm(reshape(X.core{n},[],1),1);
%ע�⣺����д1������ʱ��Ҫ���������������Ȼ�����صľ�������е�1������




end