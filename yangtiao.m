function zhi = yangtiao(P,t)
% 这个是返回多段的样条曲线的。
ns = 3 ; 
[hang lie] = size(P) ; 
duanshu = hang - ns ; %五个点是一段，七个点就是三段。
zhi = [] ; 
for(i = 1:duanshu)
%     zhi = [zhi ;Bspline4(P(i:ns+i,:),t)];
    zhi = [zhi ;Bspline3(P(i:ns+i,:),t)];
end


if(0)
    figure()
    hold on 
    for i=1:hang 
        plot(P(i,1),P(i,2),'o') ;
        text(P(i,1),P(i,2),num2str(i)) ; 
    end
    % plot(P(:,1),P(:,2),'o') ;
    plot(zhi(:,1),zhi(:,2),'-r') ; 
    % axis('equal')
    % axis([-100 100 -1 1])
    % hold off 
end
end