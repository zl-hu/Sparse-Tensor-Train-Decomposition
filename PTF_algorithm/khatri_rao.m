function C = khatri_rao(A, B)
% KHATRI_RAO 计算两个矩阵的Khatri-Rao积（列-wise Kronecker积）

% 预分配结果矩阵
m = size(A, 1);
n = size(B, 1);
[~, r] = size(A);
C = zeros(m*n, r);

% 逐列计算Kronecker积
for i = 1:r
    C(:, i) = kron(A(:, i), B(:, i));
end

end