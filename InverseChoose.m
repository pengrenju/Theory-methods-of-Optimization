function [ B,BasicVariableIndex,unBasicVariableIndex ] = InverseChoose( A )
%INVERSECHOOSE �Ӿ���A����ȡrank~=0�ķֿ����B
%   �˴���ʾ��ϸ˵��

[Row_A,Column_A] = size(A);

% �Ӿ���A��ѡ���������������ȫ�����
C = nchoosek(1:Column_A,Row_A); % ��������ȫ����Ϲ���һ������C
                                % C��ÿһ������������ϵ����
[Row_C,Column_C] = size(C);

% ������������ֿ�������
% ����������=1�ķֿ����ʱֹͣ����
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

