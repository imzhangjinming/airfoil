function zhi = subtract_2disparate(v1,v2)
% ������Χһ������size��һ�����������У�������ǿ�����������һ�������������������л��ߡ�
% Ȼ����Ӧ����v2-v1��������v2�ĳߴ硣
% Ӧ���ǵ��ı���ֵ���������������������������������ֵ�����������Ļ�Ҫ����ë�ã�

[hang2,lie2] = size(v2) ;
[hang1,lie1] = size(v1) ;

jieguo = v2  ;
jieguo(:,2) = 0 ; 

for i = 1:hang2
    for j = 1:hang1-1
        if((v2(i,1)>v1(j,1))&&(v2(i,1)<v1(j+1,1)))
            %˵���ǵ��˸ò�ֵ�ĵط��ˡ�Ȼ��һ�׵�Ҳ�Ͱ���
            bili = (v2(i,1) - v1(j,1))/(v1(j+1,1) - v1(j,1)) ; 
            v1_bijiao = (v1(j+1,:) - v1(j,:)) .* bili + v1(j,:) ;
            jieguo(i,2) = v2(i,2) - v1_bijiao(1,2) ;
            break ;
        elseif(v2(i,1)>v1(hang1,1))
            %˵���Ǽ���������,v2��v1����
            bili = (v2(i,1) - v1(hang1-1,1))/(v1(hang1,1) - v1(hang1-1,1)) ; 
            v1_bijiao = (v1(hang1,:) - v1(hang1-1,:)) .* bili + v1(hang1-1,:) ;
            jieguo(i,2) = v2(i,2) - v1_bijiao(1,2) ;
            break;
        elseif(v2(i,1)<v1(1,1))
            %˵���Ǽ��������ˣ�ǰ���ͷ�ˡ�
            bili = (v2(i,1) - v1(1,1))/(v1(2,1) - v1(1,1)) ; 
            v1_bijiao = (v1(2,:) - v1(1,:)) .* bili + v1(1,:) ;
            jieguo(i,2) = v2(i,2) - v1_bijiao(1,2) ;
        end
    end
end
zhi = jieguo ;
end