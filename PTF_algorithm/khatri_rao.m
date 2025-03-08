function C = khatri_rao(A, B)
% KHATRI_RAO �������������Khatri-Rao������-wise Kronecker����

% Ԥ����������
m = size(A, 1);
n = size(B, 1);
[~, r] = size(A);
C = zeros(m*n, r);

% ���м���Kronecker��
for i = 1:r
    C(:, i) = kron(A(:, i), B(:, i));
end

end