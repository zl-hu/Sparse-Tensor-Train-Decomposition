function rate=classify_label(V_train,V_test,train_label,test_label)
for i=1:size(V_test,2)
    for j=1:size(V_train,2)
        V_3(i,j)=norm(V_test(:,i)-V_train(:,j),'fro');
    end
end
for i=1:size(V_test,2)
            [~,V_4(i)]=min(V_3(i,:));
end

rate=sum(double(train_label(V_4)==test_label))/(size(V_test,2));
end