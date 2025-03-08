function Z=touying(X,problem)
        %计算投影PX_Omega-PA_Omega
        %A为要逼近的四阶张量
        %Omega为投影点
        tensor_size=problem.tensor_size;
        tao=problem.tao;
        t_1=whole(X,problem);%另一种计算整体张量的方法
        Z=t_1-tao;
end