function zhi = yangtiao4_d(P,t)
% ����Ƿ��ض�ε��������ߵ�΢�ֵġ�
ns = 4 ; 
[hang lie] = size(P) ; 
duanshu = hang - ns ; %�������һ�Σ��߸���������Ρ�
zhi = [] ; 
for i = 1:duanshu
    zhi = [zhi ;Bspline4_d(P(i:ns+i,:),t)];
%     zhi = [zhi ;Bspline3(P(i:ns+i,:),t)];
end

if(0)
    figure(1)
    hold on 
    for i=1:hang 
        plot(P(i,1),P(i,2),'o') ;
        text(P(i,1)+0.00,P(i,2),num2str(i)) ; 
    end
    plot(zhi(:,1),zhi(:,2),'-r') ; 
    grid on ; 
    % axis('equal')
    % axis([-100 100 -1 1])
    % hold off 
end
end