function [U,V,out] = NMF_fun(X,U0,V0,MaxIt)
U{1} = U0;
V{1} = V0;
out.obj(1)=norm(X-U{1}*V{1},'fro');
for i = 2:MaxIt
    U{i}= U{i-1}.*(X*V{i-1}')./max(U{i-1}*V{i-1}*V{i-1}',1e-6);
    V{i} = V{i-1}.*(U{i}'*X)./max(U{i}'*U{i}*V{i-1},1e-6);
    Tol = norm(X-U{i}*V{i},'fro');
    out.obj(i) = Tol;
%     if i>2 && abs(out.obj(i) - out.obj(i-1))/out.obj(i-1) < 1e-6
%         break
%     end
end