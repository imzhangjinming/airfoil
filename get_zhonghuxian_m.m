function [v,C] = get_zhonghuxian_m(chi_in,chi_out,k,xi,vpp,p_m)
%这个重新修改的、不那么偷懒的中弧线，前面生成部分还是照着阳间的搞法来，然后强行加一个修正。
%不然如果纯用没有物理含义的其实不太好。
%用加减的方式修正也是可以有说法的，因为加减不改变进出口角度，这样比较能说的过去。

[v2,C] = get_zhonghuxian(chi_in,chi_out,k,xi,vpp);

x = 0:(vpp(2,1)-vpp(1,1)):1 ; 
x = x' ; 
[hang,lie] = size(p_m) ; 
if(lie ~= 5)
    fprintf('MXairfoil: invalid input parameter for get_zhonghuxian_m \n');
end 
y = polyval(p_m,x) ; 
% modify = [x,y] ; 
v = [v2(:,1) -y+v2(:,2)] ; 

end