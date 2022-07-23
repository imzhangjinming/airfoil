function [v,C] = get_zhonghuxian_m(chi_in,chi_out,k,xi,vpp,p_m)
%��������޸ĵġ�����ô͵�����л��ߣ�ǰ�����ɲ��ֻ�����������ĸ㷨����Ȼ��ǿ�м�һ��������
%��Ȼ�������û�����������ʵ��̫�á�
%�üӼ��ķ�ʽ����Ҳ�ǿ�����˵���ģ���Ϊ�Ӽ����ı�����ڽǶȣ������Ƚ���˵�Ĺ�ȥ��

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