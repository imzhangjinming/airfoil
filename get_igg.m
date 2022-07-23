% function zhi = get_igg(wenjianming,uv_all,index)
function zhi = get_igg(wenjianming,uv_all)
%����Ƕ�ά�������ΪIGG�õ�����ѹ�����������������ݵġ�
%2021��3��22��22:01:09�°汾������Ҫindex�ˡ�

% ����תһ�¿����ǱȽϺ���ġ�
uv_all = xuanzhuan(uv_all,14.4/180*pi) ; 
% uv_suction = uv_all(1:index-2,:) ; 
% uv_pressure = uv_all(index+1:end,:) ;
% [uv_suction2,uv_pressure2] = get_shangxia(uv_all) ; 
[uv_suction,uv_pressure] = get_shangxia(uv_all) ; 
% huatu2(uv_pressure);huatu2(uv_suction)  ;
% huatu2(uv_pressure2); huatu2(uv_suction2)  ;
% % ûë������ȫһ�£�˵�����ʵ�get_shangxia����Ч�ġ�

%�������ף���Ҫתһ��14.4��İ�װ��
%2021��3��23��17:08:34������תȻ���ٷֿ����ǱȽϺ���ġ�
% uv_pressure = xuanzhuan(uv_pressure,14.4/180*pi) ; 
% uv_suction = xuanzhuan(uv_suction,14.4/180*pi) ; 
% huatu2(uv_pressure);
% huatu2(uv_suction)  ;
% huatu2(uv_pressure2);
% huatu2(uv_suction2)  ;

%Ȼ��ʼ���������ϵ������
mkdir(wenjianming) ; 

jianju = 7.62;
%��Щ����������صģ�������̫�á�����Ҳ���ˣ�shuchu_data���Ǹ������ʵġ�igg��ʽ��صĶ�����
uv_suction = chachong2(uv_suction) ;
uv_pressure = chachong2(uv_pressure) ;
uv_suction = chachong2(uv_suction) ;
uv_pressure = chachong2(uv_pressure) ;

zhi1 = shuchu_dat(wenjianming,'suction',uv_suction);
zhi2 = shuchu_dat(wenjianming,'pressure',uv_pressure);
zhi3 = shuchu_dat(wenjianming,'suction2',uv_suction-[0 jianju]);
%����ø���Ҷդ�����������㡣2021��3��22��22:05:34���϶�����4.998��
% ����һ�����ף�������7.62cm
zhi4 = shuchu_dat(wenjianming,'pressure2',uv_pressure+[0 jianju]);
zhi5 = shuchu_dat(wenjianming,'suction3',uv_suction+[0 jianju]);
zhi6 = shuchu_dat(wenjianming,'pressure3',uv_pressure-[0 jianju]);

zhi = 'MXairfoil: output igg data successfully \n -------En Taro XXH !-------\n' ;
fprintf(zhi);
end

function zhi = shuchu_dat(wenjianming,mingzi , shuju)
% ���ǳ������д��������һЩ�����ƴ�����ȫ��ɵ����Ϊ��
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
