function zhi = xuanzhuan(dian , theta)
%这个就是最纯粹的坐标旋转的东西。
%按照常理，角度是逆时针为正。

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