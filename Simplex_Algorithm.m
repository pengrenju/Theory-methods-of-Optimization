% 采用单纯形方法求最优解和最优值 %
%      simplex algorithm       %

clear
% 输入线性规划数学模型的参数 %
% 数学模型：
%          min/max cx
%          s.t.    Ax=b
%                  x>=0
% A = [-1 2 1 0 0;
%      2  3 0 1 0;
%      1 -1 0 0 1];
A = [1  2 1 0 0
     2 -1 0 1 0
     1 -4 0 0 1];
b = [10;5;4];
c = [5 -6 0 0 0];

% 给定初始基本可行解和初始基矩阵
% Set intial basic feasible solution &
% initial base matrix
[B,BasicVariableIndex,unBasicVariableIndex] = InverseChoose(A); % B 初始基矩阵
                                           % BasicVariableIndex
                                           % 基变量各分量对应的列向量在矩阵A中的位置序列
                                           % unBasicVariableIndex
                                           % 非基变量各分量对应的列向量在矩阵A中的位置序列

cB = c(BasicVariableIndex);
xB = inv(B)*b;

% 计算初始的目标函数值和单纯形乘子
f = cB*xB;     % 初始目标函数值
w = cB*inv(B); % 初始单纯形乘子
% 计算非基变量对应的判别数z
z = w*A(:,unBasicVariableIndex)-c(unBasicVariableIndex);
zk = max(z); % 找到最大的判别数
k = unBasicVariableIndex(find(z==zk)); % 确定该最大判别数对应的非基变量分量对应的列向量在矩阵A中的位置

% 开始迭代
while zk>=0   % 若求极小值min，应为 ">="
              % 若求极大值max，应为 "<="
    yk = inv(B)*A(:,k);
    if any(yk>0)
        b_ba = inv(B)*b;
        I = find(yk>=0); % 提取yk中的非负元素
        xx = b_ba(I)./yk(I);
        r = I(find(xx==min(xx))); % r等于yk中最小值所在的位置
        
        % 用列向量A(:,k)代替列向量A(:,BasicVariableIndex(r)) %
        % 首先unBasicVariableIndex中等于k的元素被unBasicVariableIndex中第r个元素替换
        % 然后BasicVariableIndex中第r个元素替换为k
        unBasicVariableIndex(find(unBasicVariableIndex==k))=BasicVariableIndex(r);
        BasicVariableIndex(r) = k;
        
        % 更新所有参数 %
        B(:,r) = A(:,k);
        cB(r) = c(k);
        xB = inv(B)*b;
        f= cB*xB;
        w = cB*inv(B);
        z = w*A(:,unBasicVariableIndex)-c(unBasicVariableIndex);
        zk = max(z);
        k = unBasicVariableIndex(find(z==zk));
    else
        disp('不存在有限个最优解');
    end
end

x = zeros(size(c));
x(BasicVariableIndex) = xB;
FinalBasicFeasibleSolution = x(c~=0);
FinalOptimum = f;
disp('最优可行解为：')
disp(FinalBasicFeasibleSolution);
disp('最优目标值为：')
disp(FinalOptimum);
        
        
        


