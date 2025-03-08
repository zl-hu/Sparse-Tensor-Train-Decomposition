clc
clear

addpath ORL
addpath funs
rng(1) % replicable

%图像尺寸调整为m_img*n_img
m_img = 28; 
n_img = 23;
%每个对象选取Train_num张图片组成训练集
Train_num = 8; 
 %每个对象剩余Test_num张图片组成测试集
Test_num = 2;

%载入训练集到V，样本分类号到class_V,载入测试集到T,样本分类号到class_T
%原始数据矩阵,每一列为一张图片
train_data = zeros(m_img * n_img , 40 * Train_num);
train_labels = zeros(40 * Train_num, 1);
test_data = zeros(m_img * n_img , 40 * Test_num);    
test_labels = zeros(40 * Test_num, 1);
for i = 1 : 40
    currPath = ['./ORL/s', num2str(i)];
    Files = dir(fullfile(currPath, '*.*'));
    LengthFiles = length(Files);
    %随机划分训练集和测试集
    rN = randperm(10);
    for j = 1 : Train_num
        img_path = [currPath ,'\' , Files(rN(j) + 2).name];
        img = imread(img_path);
        img = imresize(img, [m_img n_img]);
        %图片向量化，作为初始数据矩阵中的一个列
        img_vector = img(1 : m_img * n_img);
        %train_data(:,j + (i - 1) * Train_num) = double(img_vector);
        %存储图片
        % normalization
        train_data(:,j + (i - 1) * Train_num) = double(img_vector)/255;
        %存储类别信息
        train_labels(j + (i - 1) * Train_num) = i;
    end
    for j = 1 : Test_num
        img_path = [currPath ,'\' , Files(rN(j + Train_num) + 2).name];
        img = imread(img_path);
        img = imresize(img, [m_img n_img]);
        %图片向量化，作为初始数据矩阵中的一个列
        img_vector = img(1 : m_img * n_img);
        %test_data(:,j + (i - 1) * Test_num) = double(img_vector);
        %存储图片
        % normalization
        test_data(:,j + (i - 1) * Test_num) = double(img_vector)/255;
        %存储类别信息
        test_labels(j + (i - 1) * Test_num) = i;
    end
end

test_data = test_data;
test_labels = test_labels;

matrix_train = train_data;
matrix_labels = train_labels;


fprintf('**********ORL Datasets**********\n')
fprintf('%d training samples\n%d test samples\n',size(matrix_labels,1),size(test_labels,1))

% Problem size
[n,m] = size(matrix_train);
r = 10; %reduction dimension


% Initialization
U0 = rand(n,r);
V0 = rand(r,m);
A = matrix_train;
E = zeros(size(matrix_train));
B = A;

% normalization
UV0 = U0*V0;
U0 = U0 * sqrt(norm(matrix_train,'fro'))/sqrt(norm(UV0,'fro'));
V0 = V0 * sqrt(norm(matrix_train,'fro'))/sqrt(norm(UV0,'fro'));

fprintf('Initial Error: %.2e\n', norm(matrix_train-U0*V0,'fro'));


%% NMF
MaxIt_NMF = 100;
[U_train V_train out_train ] = NMF_fun(matrix_train, U0, V0, MaxIt_NMF);

V_test = compute_coef_fun(U_train,test_data);
rate=classify(V_train,V_test,s2,s3);


fprintf('**********Accuracy with r=%d**********\n',r);
fprintf('|Original| NMF \n');
fprintf('| %.4f | %.4f \n',AC_original,AC_NMF)
fprintf('*****************END*****************\n');