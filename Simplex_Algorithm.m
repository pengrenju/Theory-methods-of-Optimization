% ���õ����η��������Ž������ֵ %
%      simplex algorithm       %

clear
% �������Թ滮��ѧģ�͵Ĳ��� %
% ��ѧģ�ͣ�
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

% ������ʼ�������н�ͳ�ʼ������
% Set intial basic feasible solution &
% initial base matrix
[B,BasicVariableIndex,unBasicVariableIndex] = InverseChoose(A); % B ��ʼ������
                                           % BasicVariableIndex
                                           % ��������������Ӧ���������ھ���A�е�λ������
                                           % unBasicVariableIndex
                                           % �ǻ�������������Ӧ���������ھ���A�е�λ������

cB = c(BasicVariableIndex);
xB = inv(B)*b;

% �����ʼ��Ŀ�꺯��ֵ�͵����γ���
f = cB*xB;     % ��ʼĿ�꺯��ֵ
w = cB*inv(B); % ��ʼ�����γ���
% ����ǻ�������Ӧ���б���z
z = w*A(:,unBasicVariableIndex)-c(unBasicVariableIndex);
zk = max(z); % �ҵ������б���
k = unBasicVariableIndex(find(z==zk)); % ȷ��������б�����Ӧ�ķǻ�����������Ӧ���������ھ���A�е�λ��

% ��ʼ����
while zk>=0   % ����Сֵmin��ӦΪ ">="
              % ���󼫴�ֵmax��ӦΪ "<="
    yk = inv(B)*A(:,k);
    if any(yk>0)
        b_ba = inv(B)*b;
        I = find(yk>=0); % ��ȡyk�еķǸ�Ԫ��
        xx = b_ba(I)./yk(I);
        r = I(find(xx==min(xx))); % r����yk����Сֵ���ڵ�λ��
        
        % ��������A(:,k)����������A(:,BasicVariableIndex(r)) %
        % ����unBasicVariableIndex�е���k��Ԫ�ر�unBasicVariableIndex�е�r��Ԫ���滻
        % Ȼ��BasicVariableIndex�е�r��Ԫ���滻Ϊk
        unBasicVariableIndex(find(unBasicVariableIndex==k))=BasicVariableIndex(r);
        BasicVariableIndex(r) = k;
        
        % �������в��� %
        B(:,r) = A(:,k);
        cB(r) = c(k);
        xB = inv(B)*b;
        f= cB*xB;
        w = cB*inv(B);
        z = w*A(:,unBasicVariableIndex)-c(unBasicVariableIndex);
        zk = max(z);
        k = unBasicVariableIndex(find(z==zk));
    else
        disp('���������޸����Ž�');
    end
end

x = zeros(size(c));
x(BasicVariableIndex) = xB;
FinalBasicFeasibleSolution = x(c~=0);
FinalOptimum = f;
disp('���ſ��н�Ϊ��')
disp(FinalBasicFeasibleSolution);
disp('����Ŀ��ֵΪ��')
disp(FinalOptimum);
        
        
        


