function [v,C] = get_zhonghuxian_toulan(chi_in,chi_out,k,xi,vpp,p_camber)
%这个是把shishi_zhonghuxian封装成函数的。为了稍微靠谱一些。

vp = jifen(vpp) ; 
vp(:,2) = vp(:,2)*k + tan(chi_in) ; 
v = jifen(vp) ; 
% plot(v(:,1),v(:,2)) ; %到这里，输出的已经是文献里的那个中弧线了。

%然后计算一下中弧线的曲率分布啊那些。
C = zeros(size(v)) ; 
C(:,1) = v(:,1) ; 
C(:,2) = vpp(:,2)./(1 + vp(:,2).^2).^(3/2) ; 
% plot(C(:,1),C(:,2)) ; 

x = 0:0.025:1 ; 
x = x' ; 
[hang,lie] = size(p_camber) ; 
if(lie ~= 4)
    fprintf('MXairfoil: invalid input parameter for get_zhonghuxian_toulan \n');
end 
y = polyval(p_camber,x) ; 
camber = [x,y] ; 
v = camber ; 

end