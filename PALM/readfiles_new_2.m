function [train_orl,test_orl]=readfiles_new_2(s1,s2,s3)
% Read ORL dataset and Image preprocessing



total= randperm(10);
%total= 1:10;
train_label=total(1:s2);
test_label=total(s2+1:10);

for i=1:s1
    for j=1:s2
        img=imread(['ORL_data\s' num2str(i) '\' num2str(train_label(j)) '.pgm']);
        img_1=imresize(img,[28 23]);
        train_orl(:,:,s2*(i-1)+j)=double(img_1)/255;
    end
end

for i=1:s1
    for j=1:s3
        kimg_test=imread(['ORL_data\s' num2str(i) '\' num2str(test_label(j)) '.pgm']);
        kimg_1test=imresize(kimg_test,[28 23]);
        test_orl(:,:,s3*(i-1)+j)=double(kimg_1test)/255;
    end
end

end
