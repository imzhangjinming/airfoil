function [v,C] = get_zhonghuxian_toulan(chi_in,chi_out,k,xi,vpp,p_camber)
%����ǰ�shishi_zhonghuxian��װ�ɺ����ġ�Ϊ����΢����һЩ��

vp = jifen(vpp) ; 
vp(:,2) = vp(:,2)*k + tan(chi_in) ; 
v = jifen(vp) ; 
% plot(v(:,1),v(:,2)) ; %�����������Ѿ�����������Ǹ��л����ˡ�

%Ȼ�����һ���л��ߵ����ʷֲ�����Щ��
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