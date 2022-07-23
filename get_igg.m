% function zhi = get_igg(wenjianming,uv_all,index)
function zhi = get_igg(wenjianming,uv_all)
%这个是二维翼型输出为IGG用的那种压力面吸力面两列数据的。
%2021年3月22日22:01:09新版本，不需要index了。

% 先旋转一下恐怕是比较合理的。
uv_all = xuanzhuan(uv_all,14.4/180*pi) ; 
% uv_suction = uv_all(1:index-2,:) ; 
% uv_pressure = uv_all(index+1:end,:) ;
% [uv_suction2,uv_pressure2] = get_shangxia(uv_all) ; 
[uv_suction,uv_pressure] = get_shangxia(uv_all) ; 
% huatu2(uv_pressure);huatu2(uv_suction)  ;
% huatu2(uv_pressure2); huatu2(uv_suction2)  ;
% % 没毛病，完全一致，说明劳资的get_shangxia是有效的。

%根据文献，还要转一个14.4°的安装角
%2021年3月23日17:08:34，先旋转然后再分恐怕是比较合理的。
% uv_pressure = xuanzhuan(uv_pressure,14.4/180*pi) ; 
% uv_suction = xuanzhuan(uv_suction,14.4/180*pi) ; 
% huatu2(uv_pressure);
% huatu2(uv_suction)  ;
% huatu2(uv_pressure2);
% huatu2(uv_suction2)  ;

%然后开始真正意义上的输出了
mkdir(wenjianming) ; 

jianju = 7.62;
%这些个是算例相关的，讲道理不太好。不过也罢了，shuchu_data才是根本性质的、igg格式相关的东西。
uv_suction = chachong2(uv_suction) ;
uv_pressure = chachong2(uv_pressure) ;
uv_suction = chachong2(uv_suction) ;
uv_pressure = chachong2(uv_pressure) ;

zhi1 = shuchu_dat(wenjianming,'suction',uv_suction);
zhi2 = shuchu_dat(wenjianming,'pressure',uv_pressure);
zhi3 = shuchu_dat(wenjianming,'suction2',uv_suction-[0 jianju]);
%这个得根据叶栅的数据重新算。2021年3月22日22:05:34，肯定不是4.998了
% 看了一眼文献，这里是7.62cm
zhi4 = shuchu_dat(wenjianming,'pressure2',uv_pressure+[0 jianju]);
zhi5 = shuchu_dat(wenjianming,'suction3',uv_suction+[0 jianju]);
zhi6 = shuchu_dat(wenjianming,'pressure3',uv_pressure-[0 jianju]);

zhi = 'MXairfoil: output igg data successfully \n -------En Taro XXH !-------\n' ;
fprintf(zhi);
end

function zhi = shuchu_dat(wenjianming,mingzi , shuju)
% 还是抽象出来写个函数好一些。复制代码完全是傻逼行为。
%suction 
[hang,lie] = size(shuju) ; 
wenjian = fopen([wenjianming '\' mingzi '.dat'],'w') ;
fprintf(wenjian ,[mingzi '\n']);
fprintf(wenjian,'2 0 0 \n') ; 
fprintf(wenjian ,'%d \n',hang);
for i=1:hang 
    fprintf(wenjian ,'%f %f \n',shuju(i,1),shuju(i,2));
end 
zhi = fclose(wenjian);
end 
