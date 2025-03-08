function [Y,x, err]=NTT_RALS_1(A, r, itemax, rtol, lambda)
% NTTF model:   min  1/2*||A-X||_f^2+λ||X||_1
%               s.t. TT-rank(X)=r,  X>=0 
% Customized for A with proper size 
% A: nonnegative tensor of size N1*N2*.....*Nd
% r: given TT ranks
% x: TT cores x{i} of size r(i)*Ni*r(i+1)
% TYPE: Method to used: 'NNRALS' or 'NNALS' 
% rtol: relative error tolerence, where ERR=norm(A-X)/norm(A) 

% Normalize initial X with coefficients 
% function [train_orl, test_orl]=readfiles_new(train_cnt)
% Read ORL dataset and Image preprocessing


n=size(A);   d=length(n);
if numel(r)==1    %若r只有一个元素
    r=r*ones(1,d+1); 
    r(1) = 1;    r(d+1)=1;
end
    

    x=cell(1,d);  
    for i=1:d
         x{i}=rand(r(i), n(i), r(i+1)); 
         x{i}=x{i}/norm(x{i}(:));  %"x{i}(:)"表示将张量x按列拆开排列成一个大列向量  
    end


Matd=cell(1,d+1);   
Matd{1}=1;  Matd{d+1}=1;  lam=1;
for i=d:-1:2    
    temp=reshape(x{i}, r(i)*n(i),r(i+1))*diag(lam);
    temp=reshape(temp, r(i), n(i)*r(i+1));
    lam=sum(temp, 2);
    temp=temp./kron(lam, ones(1, n(i)*r(i+1)));
    x{i}=reshape(temp, r(i), n(i), r(i+1));
    
    Matd{i}=reshape(temp, r(i)*n(i), r(i+1))*Matd{i+1};
    Matd{i}=reshape(Matd{i}, r(i), n(i)*size(Matd{i+1},2));
end
x{1}=reshape(x{1}, r(1)*n(1),r(2))*diag(lam);
x{1}=reshape(x{1}, r(1), n(1), r(2));

ite=1;    err_ite=rtol+1;    %lambda=1;
while  ite <= itemax  &&  err_ite > rtol
    loopind=mod(ite-1,2*(d-1))+1;
    dir=(loopind < d-0.5);    
    if loopind <= d
        ind=loopind;
    else
        ind=2*d-loopind;
    end
    
   
     %Use active-set method to update the cores and compute relative error    
         pi=1:d;  pi(ind)=[];               %从pi中删除ind  
         tempA=reshape(permute(A, [pi, ind]), prod(n)/n(ind), n(ind));     
         C=kron(Matd{ind+1}', Matd{ind});
         y=zeros(r(ind)*r(ind+1), n(ind));
         for j=1:n(ind)
             y(:, j)=max(lsqnonneg(C, tempA(:,j)-lambda), 1e-16);  % The solution maybe zero
         end     
         err_ite=norm(C*y-tempA,'fro')/norm(tempA, 'fro');
         err(ite)=err_ite;      
         y=permute(reshape(y, r(ind), r(ind+1), n(ind)), [1 3 2]);
         ite

    
    %%Update Matd to prepare the next iteration
    if dir==1 
        yy=reshape(y, r(ind)*n(ind), r(ind+1));
        lam=sum(yy);
        x{ind}=yy./kron(ones(r(ind)*n(ind), 1), lam);
        x{ind}=reshape(x{ind}, r(ind), n(ind), r(ind+1));
        x{ind+1}=diag(lam)*reshape(x{ind+1}, r(ind+1), n(ind+1)*r(ind+2));
        x{ind+1}=reshape(x{ind+1}, r(ind+1), n(ind+1), r(ind+2));        
        
        
        Matd{ind+1}=Matd{ind}*reshape(x{ind}, r(ind), n(ind)*r(ind+1));
        Matd{ind+1}=reshape(Matd{ind+1}, size(Matd{ind+1},1)*n(ind), r(ind+1));
    end
    if dir==0
        yy=reshape(y, r(ind), n(ind)*r(ind+1));
        lam=sum(yy, 2);
        x{ind}=yy./kron(lam, ones(1, n(ind)*r(ind+1)));
        x{ind}=reshape(x{ind}, r(ind), n(ind), r(ind+1));
        x{ind-1}=reshape(x{ind-1}, r(ind-1)*n(ind-1), r(ind))*diag(lam);
        x{ind-1}=reshape(x{ind-1}, r(ind-1), n(ind-1), r(ind));       
        
        
        Matd{ind}=reshape(x{ind}, r(ind)*n(ind), r(ind+1))*Matd{ind+1};
        Matd{ind}=reshape(Matd{ind}, r(ind), n(ind)*size(Matd{ind+1},2));        
    end
    if mod(ite,3)==0
        Y{floor(ite/3)}.core=x;
        
        
    end
    ite=ite+1;     
end

end


