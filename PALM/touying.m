function Z=touying(X,problem)
        %����ͶӰPX_Omega-PA_Omega
        %AΪҪ�ƽ����Ľ�����
        %OmegaΪͶӰ��
        tensor_size=problem.tensor_size;
        tao=problem.tao;
        t_1=whole(X,problem);%��һ�ּ������������ķ���
        Z=t_1-tao;
end