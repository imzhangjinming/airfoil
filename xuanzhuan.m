function zhi = xuanzhuan(dian , theta)
%�����������������ת�Ķ�����
%���ճ����Ƕ�����ʱ��Ϊ����

juzheng = [cos(theta) -sin(theta) ;...
           sin(theta) cos(theta) ];
zhi = (juzheng * dian')' ; 

if(0)
    figure(1) ; 
    hold on ; 
    plot(dian(:,1),dian(:,2)) ; 
    plot(zhi(:,1),zhi(:,2)) ; 
    axis('equal') ; 
    grid on ; 
%     hold off ; 
end

end