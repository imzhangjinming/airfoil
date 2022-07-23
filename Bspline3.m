function zhi = Bspline3(P,t)
% 弄一个计算样条曲线的。稍微专业一点。因为要多次用到的这个。
ns = 3 ; 
[hang lie] = size(P) ; 
dianshu = size(t) ; 
B = cell(4,1) ; 
B{1} = (1-t).^3/6 ; 
B{2} = (3*t.^3 - 6*t.^2 + 4)/6 ; 
B{3} = (-3*t.^3 + 3*t.^2 + 3*t + 1)/6 ;
B{4} = t.^3/6 ;
% B{5} = t.^4/24 ; 
%讲道理这里面的t应该不是实际的坐标而只是某种参数。实际的两个坐标都应该是在返回值里面的。
zhi = zeros(dianshu(1),lie);
for(n = 1:ns+1)
    zhi = zhi + [P(n,1)*B{n}' P(n,2)*B{n}'] ; 
end 

%检测一下靠谱程度如何。
% figure()
% hold on 
% plot(P(:,1),P(:,2),'o') ;
% hold on 
% plot(zhi(:,1),zhi(:,2),'-r') ; 
% axis('equal')
% hold off 
end