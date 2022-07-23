function [v,C] = get_zhonghuxian(chi_in,chi_out,k,xi,vpp)
%这个是把shishi_zhonghuxian封装成函数的。为了稍微靠谱一些。

vp = jifen(vpp) ; 
vp(:,2) = vp(:,2)*k + tan(chi_in) ; 
%2021年3月31日14:27:09，增加一些操作，把chi_out的影响也考虑进来。
vpend_cha = -vp(end,2)+tan(chi_out) ;
vp(:,2) = vp(:,2) + vpend_cha.*(vp(:,1)) ; 
%姑且算是个均匀过渡，而且前面是进口占主导，后面是出口占主导
%2021年3月31日14:38:21这些地方后面都需要考虑改成样条，因为有一手独一无二的特性，变量改变是局部的。


v = jifen(vp) ; 
% plot(v(:,1),v(:,2)) ; %到这里，输出的已经是文献里的那个中弧线了。

%然后计算一下中弧线的曲率分布啊那些。
C = zeros(size(v)) ; 
C(:,1) = v(:,1) ; 
C(:,2) = vpp(:,2)./(1 + vp(:,2).^2).^(3/2) ; 
% plot(C(:,1),C(:,2)) ; 
end