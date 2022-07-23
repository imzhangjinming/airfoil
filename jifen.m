function zhi = jifen(uv)
% 弄一个积分的，这样显得专业一点。这里面就纯积分了，加减的时候外面再说。
% 一般地，这里面的v其实是外面的vpp之类的。
[hang lie] = size(uv) ; 
u = uv(:,1) ; %多消耗一些资源而方便理解一些是问题不大的。更何况这个本来也不怎么有计算量 
v = uv(:,2) ;
zhi = zeros(size(uv)) ; 
zhi(:,1) = u ; 
% zhongjie = 0 ; 
zhi(1,2) = 0 ; %这个是初值了。
for i=2:hang     
%     zhi(i,2) = zhi(i-1,2) + (u(i) - u(i-1))*(v(i)) ; 
    zhi(i,2) = zhi(i-1,2) + (u(i) - u(i-1))*(v(i) + v(i-1))/2 ; 
end 

% figure()
% hold on 
% plot(zhi(:,1),zhi(:,2),'-r') ; 
% % axis('equal')
% hold off 
end