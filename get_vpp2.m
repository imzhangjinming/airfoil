function zhi = get_vpp2(wenjianming)
%��������Ǵ���֮ǰ���������⡣2020��10��21��13:48:32
%ͨ����ȡ�����������ļ�����Щ�Ƕ�ɶ��������vpp��
% 2021��3��2��09:37:38����Ŀ�ʼʵ�û��ؼ������ˡ�

dianshu = 35 ; %��Ϊ���˼������������������ôЩ�㡣
% Nmax=14 ;
%��Ϊ��0��ʼ�ɣ����Ǿ������רҵ�㡣
dt = 1/(dianshu-1) ; 
t=0:dt:1 ;  %�������̵Ĳ�������Ҫ���������ġ�
% changshu = -1*log(N)/log(Nmax) ; %0�仯��-1
x=t ; 

% parameter = load('../input/test3/vpp/vpp_parameter.txt') ;
parameter = load(wenjianming) ;
[hang,lie] = size(parameter) ; 
changshu = parameter(1) ; 
if(lie ~= 8)
    fprintf('MXairfoil: invalid input parameter for get_vpp2');
end 
y=(1./(parameter(2)-sin(x*pi+pi*parameter(3)))-...
    1/(parameter(4)-sin(0*pi+pi*parameter(5))))*(parameter(6)+changshu)...
    +(- parameter(7) -changshu+changshu*parameter(8)*x + 0.2);
%2020��10��21��15:46:04�����Ҿ������ɣ���ϵĶ������²�������໡�
%2020��10��21��15:50:16��Ȼ��������໣�Ū���������ͺ�ԭ����Ļ�ͦԶ�ġ�
%2020��10��21��16:46:39���������������ϵ�������Ժ�Ŀ�ѡ���Ż�������
%2020��10��21��16:47:08�����ܰ���һЩ��С��������ܹ��ȽϺõ�ѧϰ������ֲ������Ǹо����岻���ˡ�
%�������������޴���Ψ��Ķ��������ҹ��ɽ�������������Ϊ���ﵽ���������ÿ�Ҳ��


huatu2([x',y']);

%���������Ϊ�ǳ�ʼ���ɣ���һ������Ļ2020��10��21��16:30:09���ԣ����������ˣ�Ҫ�������ˡ�



zhi = [x',y'] ; 
fprintf('���ԣ�get_vpp,��%d������\n',7)
% huatu2(zhi) ; 
end 