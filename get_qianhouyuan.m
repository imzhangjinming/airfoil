function [uv_top3,uv_bot3] = get_qianhouyuan(uv_top,uv_bot,lethk ,tethk,chi_in,chi_out)
%����ǰ�shishi_qianhouyuan�ĳɺ�����ʽ������һЩ��
% % %ǰ��Ե����Ҫ����һ�µģ���Ӧ�þ�ֱ�ӷ��������ˡ����¼򻯷���Ҳ�ã�˵��Ҫ�еġ�
% % %Ū���Ժ��ȫ���ᵽ��������ȥ�ˡ��ͱȽ������໡�
% [uv_top2 , uv_bot2] = get_qianyuan(uv_top,uv_top(:,3) ,uv_bot,uv_bot(:,3),lethk ,chi_in ,...
%     12,0.01,0.4,0.4,0.8,1.6) ; %�����������
% 2021��3��22��20:04:25��ע�⵽�ˣ������ĺ����ǲ��Ǻܶԣ��ٲ���һ�¡�
% [uv_top2 , uv_bot2] = get_qianyuan2(uv_top,uv_top(:,3) ,uv_bot,uv_bot(:,3),...
%     lethk ,chi_in ,0,0,0,0,0,0) ; %�����ԲǰԵ�ġ�
[uv_top2 , uv_bot2] = get_qianyuan22(uv_top,uv_top(:,3) ,uv_bot,uv_bot(:,3),...
    lethk ,chi_in ,0,0,0,0,0,0) ; %�����ԲǰԵ�ġ��Ľ���һ�£����˵���͵����Ƿծ��
% [uv_top2 , uv_bot2] = get_qianyuan3(uv_top,uv_top(:,3) ,uv_bot,uv_bot(:,3),lethk ,chi_in ,0) ;
% % 2020��6��20��17:08:54������µ������ģ�����������ûë���ġ����������������ǲ���
% [uv_top22 , uv_bot22] = get_qianyuan4(uv_top,uv_top(:,3) ,uv_bot,uv_bot(:,3),lethk ,chi_in ,0) ;
% 2020��6��20��19:43:21������µ����ε������ģ����Կ���ǰԵ��λ���ˡ�
% % ���Ҳ�ǳ���������һ�������õ��ˡ�����֮ǰΪʲôҪ��ʱ�侫��ȥ�������������Ǹ����������ģ�
% [uv_top2 , uv_bot2] = get_qianyuan5(uv_top,uv_bot,lethk,chi_in);
% ���Ҳ�����С���Ȼ���������Ǵ���֪����Ϊʲô���У�������Ȼû�н��Ϊʲô���С�

% mydebug(uv_top2) ; 
% plot(uv_top2(:,1) , uv_top2(: ,2)) ; 
% hold on
% plot(uv_bot2(:,1) , uv_bot2(:,2)) ; 
% axis('equal') ; 

uv_top2(:,1) = 1 - uv_top2(:,1) ; 
uv_bot2(:,1) = 1 - uv_bot2(:,1) ; 
% �Գƹ�ȥ���Ը���ǰ��ĸ��ִ�����ʱ���ǰ�����һ�ѷ�װһ���ˡ�

% plot(uv_top2(:,1) , uv_top2(: ,2)) ; 
% hold on
% plot(uv_bot2(:,1) , uv_bot2(:,2)) ; 
% axis('equal') ; 

% [uv_top3 , uv_bot3] = get_qianyuan(flipud(uv_top2),flipud(uv_top(:,4)),...
%     flipud(uv_bot2),flipud(uv_bot(:,4)),tethk ,-chi_out ,...
%     25,0.004,0.3,0,0.8,0.3) ; 
% [uv_top3 , uv_bot3] = get_qianyuan2(flipud(uv_top2),flipud(uv_top(:,4)),...
%     flipud(uv_bot2),flipud(uv_bot(:,4)),tethk ,-chi_out ,...
%     0,0,0,0,0,0) ; 
% �������һ������ת��Ҫ��Ϊ�˼���֮ǰ�Ĳ�ѯ�����һϵ�еĶ�����

[uv_top3 , uv_bot3] = get_qianyuan22(flipud(uv_top2),flipud(uv_top(:,4)),...
    flipud(uv_bot2),flipud(uv_bot(:,4)),tethk ,-chi_out ,...
    0,0,0,0,0,0) ; 

%�����ﳢ�Բ����������߰汾�ĺ�Ե
% [uv_top3 , uv_bot3] = get_qianyuan5(flipud(uv_top2),flipud(uv_bot2),tethk,-chi_out);


% �ã�������Ȼ���ٷ�ת��ȥ��
uv_top3(:,1) = 1 - uv_top3(:,1) ; 
uv_bot3(:,1) = 1 - uv_bot3(:,1) ; 

% plot(uv_top3(:,1) , uv_top3(: ,2)) ; 
% hold on
% plot(uv_bot3(:,1) , uv_bot3(:,2)) ; 
% axis('equal') ; 

end 