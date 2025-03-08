function rate=classify(V_train,V_test,s2,s3)
for i=1:size(V_test,2)
    for j=1:size(V_train,2)
        V_3(i,j)=norm(V_test(:,i)-V_train(:,j),'fro');
    end
end
for i=1:size(V_test,2)
            [val,V_4(i)]=min(V_3(i,:));
end
kidx_test=floor(V_4/(s2+0.0001))+1;
kidx_real=floor([1:size(V_test,2)]/(s3+0.0001))+1;
rate=sum(double(kidx_test==kidx_real))/(size(V_test,2));
end