function Y=normize(X) 







for j=1:3
        for k=1:3
        y{k}=column_norm(X.core{k}); 
        end
        y_aver=((y{1}.*y{2}.*y{3}).^(1/3));
        X.core{j}=X.core{j}./(y_aver./y{j});
end
 Y=X;  
end
 


