function zhi = Bspline4_d2(P,t)
% 弄一个计算样条曲线的二阶微分的。稍微专业一点。因为要多次用到的这个。
ns = 4 ; 
[hang lie] = size(P) ; 
dianshu = size(t) ; 
B = cell(5,1) ; 
B{1} = 12*(1-t).^2/24 ; 
B{2} = (-48*t.^2 + 72*t-12)/24 ; 
B{3} = (72*t.^2 - 72*t - 12)/24 ;
B{4} = (-48*t.^2 + 24*t + 12)/24 ;
B{5} = 12*t.^2/24 ; 
%讲道理这里面的t应该不是实际的坐标而只是某种参数。实际的两个坐标都应该是在返回值里面的。
zhi = zeros(dianshu(1),lie);
for n = 1:ns+1
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