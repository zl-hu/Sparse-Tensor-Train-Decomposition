function [train_orl,test_orl]=readfiles_new_1(s1,s2,s3)
% Read ORL dataset and Image preprocessing



total= randperm(10);
train_label=total(1:s2);
test_label=total(s2+1:10);

for i=1:s1
    for j=1:s2
        img=imread(['C:\Users\zhiyi\Desktop\face_recognition\ORL_data\s' num2str(i) '\' num2str(train_label(j)) '.pgm']);
        img_1=imresize(img,[28 23]);
        img_2=reshape(double(img_1)/255,[],1);
        train_orl(:,s2*(i-1)+j)=img_2;
    end
end

for i=1:s1
    for j=1:s3
        kimg_test=imread(['C:\Users\zhiyi\Desktop\face_recognition\ORL_data\s' num2str(i) '\' num2str(test_label(j)) '.pgm']);
        kimg_1test=imresize(kimg_test,[28 23]);
        kimg_2test=reshape(double(kimg_1test)/255,[],1);
        test_orl(:,s3*(i-1)+j)=kimg_2test;
    end
end

end
