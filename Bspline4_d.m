function zhi = Bspline4_d(P,t)
% 弄一个计算样条曲线的微分的。稍微专业一点。因为要多次用到的这个。
ns = 4 ; 
[hang lie] = size(P) ; 
dianshu = size(t) ; 
B = cell(5,1) ; 
B{1} = -4*(1-t).^3/24 ; 
B{2} = (-16*t.^3 + 36*t.^2 - 12*t-12)/24 ; 
B{3} = (24*t.^3 - 36*t.^2 - 12*t + 12)/24 ;
B{4} = ( -16*t.^3 + 12*t.^2 + 12*t + 4)/24 ;
B{5} = 4*t.^3/24 ; 
%讲道理这里面的t应该不是实际的坐标而只是某种参数。实际的两个坐标都应该是在返回值里面的。
zhi = zeros(dianshu(1),lie);
for n = 1:ns+1
    zhi = zhi + [P(n,1)*B{n}' P(n,2)*B{n}'] ; 
end 

end