% 非线性规划函数逼近法中的牛顿法 %
% 在极小点附近用二阶Taylor多项式近似目标函数f(x)，
% 进而求出极小点的估计值
clear

% 输入目标函数
syms x
f = 3*x^4-4*x^3-12*x^2; 
% 输入初始点
x = -1.2;
% 输入最大迭代次数
N = 3;


% 计算目标函数的一阶导数和二阶导数
g1 = diff(f);
g2 = diff(diff(f));

% 开始迭代
n = 0;
while n<N
    x = x-subs(g1)/subs(g2);
    n = n+1;
end
disp(double(x))

