function [uv_top2,uv_bot2] = get_qianyuan6(uv_top,flag_top ,uv_bot,flag_bot,lethk ,chi_in)
%��������������������Լ����һӦ��Ҫ֮�Ȼ��������Ϻõ����������ߡ�
%��������ǰ��Ե�ġ�������ٵó��Զ��������԰�

uv_top = chachong(uv_top) ; 
uv_bot = chachong(uv_bot) ; 
[hang lie] = size(uv_top) ;

[uv_le_top ,N_le_top] = chaxun2(uv_top,flag_top) ;
[uv_le_bot ,N_le_bot] = chaxun2(uv_bot,flag_bot) ;

uv_top_r = xuanzhuan(uv_top(:,1:2),-chi_in);%��r��ǵ�����ת֮�������ϵ�ġ�
uv_bot_r = xuanzhuan(uv_bot(:,1:2),-chi_in);

end