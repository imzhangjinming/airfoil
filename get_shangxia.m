function [y_top,y_bot] = get_shangxia(yixing)
%��һ��ͨ�õĹ��ߣ�������һ�����������Ͳ�ֳ���������������֡�
index_min = find(yixing(:,1)==min(yixing(:,1)));
index_min = index_min(1) ; 
% ȥ�л��ƨ���ˣ�����һȥ���������ٻ���д�ˡ�2021��3��20��19:04:18
% 2021��3��21��12:52:09����д��
index_max = find(yixing(:,1)==max(yixing(:,1)));
index_max = index_max(1) ; 
y_top =  [] ; 
y_bot = [] ; 
if(yixing(index_min,2)>yixing(index_min+1,2))
    %x��С���Ǹ��㣬����һ���㣬y����С,˵��ǰ��˳�������쵽�±���ȥ��
    if(index_min<index_max)
        %�������ģ�ֱ�����ӵ������ˡ�
        y_bot = [y_bot ; yixing(index_min:index_max,:)] ;
        y_top = [y_top ; flipud(yixing(1:index_min,:))  ;flipud(yixing(index_max:end,:)) ] ; 
        %���д�����е��ظ���
    elseif(index_min>index_max)
        %����ĵ�������ǰ��
        y_top = [y_top ; flipud(yixing(index_max:index_min,:))];
        y_bot = [y_bot ; yixing(index_min:end,:) ; yixing(1:index_max,:)] ;
    else
        fprintf('MXairfoil: ��������ûд���õ����ֳ�дһ�°�. \n get_shangxia \n')
        mydebug(index_min);
    end
elseif(yixing(index_min,2)<yixing(index_min+1,2))
    %x��С���Ǹ��㣬����һ���㣬y������,˵��ǰ��˳�������쵽�ϱ���ȥ��
    y_top = [y_top ; yixing(index_min:index_max,:)] ; 
    y_bot = [y_bot ; flipud(yixing(1:index_min,:)) ; flipud(yixing(index_max:end,:))] ; 
%     mydebug(yixing);
%     fprintf('MXairfoil: ��������ûд���õ����ֳ�дһ�°�. \n get_shangxia \n')
else
    mydebug(yixing);
    fprintf('MXairfoil: ��������ûд���õ����ֳ�дһ�°�. ����������������� \n get_shangxia \n')
end

end