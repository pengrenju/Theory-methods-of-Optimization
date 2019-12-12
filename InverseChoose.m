function [ B,BasicVariableIndex,unBasicVariableIndex ] = InverseChoose( A )
%INVERSECHOOSE 从矩阵A中提取rank~=0的分块矩阵B
%  A 待分解矩阵
%  B 秩为1的分块矩阵
%  BasicVariableIndex   基变量各分量对应的列向量在矩阵A中的位置序列
%  unBasicVariableIndex 非基变量各分量对应的列向量在矩阵A中的位置序列

[Row_A,Column_A] = size(A);

% 从矩阵A中选择方阵，输出列向量的全体组合
C = nchoosek(1:Column_A,Row_A); % 列向量的全体组合构成一个矩阵C
                                % C中每一行是列向量组合的序号
[Row_C,Column_C] = size(C);

% 依次搜索计算分块矩阵的秩
% 当搜索到秩=1的分块矩阵时停止搜索
for i = 1:Row_C
    BasicVariableIndex = C(i,:);
    B = A(:,BasicVariableIndex);
    if rank(B)~=0
        break
    end
end


unBasicVariableIndex = [];
for j = 1:Column_A
    k = any(BasicVariableIndex==j);
    if k==0
        unBasicVariableIndex = [unBasicVariableIndex,j];
    end
end
        


end

