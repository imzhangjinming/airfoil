function [uv_top2,uv_bot2] = get_qianyuan6(uv_top,flag_top ,uv_bot,flag_bot,lethk ,chi_in)
%这个是输入上下两条线以及别的一应需要之物，然后输出整合好的上下两条线。
%重新整个前后缘的。这个至少得尝试二阶连续性罢

uv_top = chachong(uv_top) ; 
uv_bot = chachong(uv_bot) ; 
[hang lie] = size(uv_top) ;

[uv_le_top ,N_le_top] = chaxun2(uv_top,flag_top) ;
[uv_le_bot ,N_le_bot] = chaxun2(uv_bot,flag_bot) ;

uv_top_r = xuanzhuan(uv_top(:,1:2),-chi_in);%带r标记的是旋转之后的坐标系的。
uv_bot_r = xuanzhuan(uv_bot(:,1:2),-chi_in);

end