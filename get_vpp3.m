function zhi = get_vpp3(wenjianming)
% ��һ������Ķ�ȡ����CDA������
%ͨ����ȡ�����������ļ�����Щ�Ƕ�ɶ��������vpp��
% 2021��3��2��09:37:38����Ŀ�ʼʵ�û��ؼ������ˡ�

x = 0:0.025:1 ; 
x = x' ; 
parameter = load(wenjianming) ;
[hang,lie] = size(parameter) ; 
if(lie ~= 4)
    fprintf('MXairfoil: invalid input parameter for get_vpp3');
end 

y = polyval(parameter,x) ; 
vpp = [x,y] ; 
% huatu2(vpp);
%���������Ϊ�ǳ�ʼ���ɣ���һ������Ļ2020��10��21��16:30:09���ԣ����������ˣ�Ҫ�������ˡ�
zhi = vpp;
fprintf('���ԣ�get_vpp3,CDA \n') ;
% huatu2(zhi) ; 
end 