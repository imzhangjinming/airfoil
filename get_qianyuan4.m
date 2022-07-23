function [uv_top2,uv_bot2] = get_qianyuan4(uv_top,flag_top ,uv_bot,flag_bot,lethk ,chi_in ,...
    xishu)
%��������������������Լ����һӦ��Ҫ֮�Ȼ��������Ϻõ����������ߡ�
%2020��6��20��15:43:05����������о�֮��ĸ߶ȼ򻯵ġ�ֱ�������������ߣ�ǰ����Ƶ�������
%���������֮��һ�������������ɵسɹ��ˡ�
% 2020��6��20��18:09:28�������3�Ļ��������Ū���������ߵġ�


t = 0:0.1:1 ; 
uv_top = chachong(uv_top) ; 
uv_bot = chachong(uv_bot) ; 
[hang,~] = size(uv_top) ;

[uv_le_top ,N_le_top] = chaxun2(uv_top,flag_top) ;
[uv_le_bot ,N_le_bot] = chaxun2(uv_bot,flag_bot) ;
uv_le_r = xuanzhuan([uv_le_top ;uv_le_bot],-chi_in);

% Ȼ�������Ƶ㡣
%����漰����̫�࣬�ڶ���֮ǰר��Ūһ������������ڡ�
uv_top_r = xuanzhuan(uv_top(:,1:2),-chi_in);%��r��ǵ�����ת֮�������ϵ�ġ�
uv_bot_r = xuanzhuan(uv_bot(:,1:2),-chi_in);

uinle = 1/2*(uv_le_r(1,1)+uv_le_r(2,1)) ; %����������������ƽ��һ�������������ʵô�õ�һ��Ҳ�С�

%Ȼ���Ǵ���һ����һ��΢�֡�
[hang,~] = size(uv_top) ;
dvdu_top = weifen(uv_top_r(N_le_top:hang,2),uv_top_r(N_le_top:hang,1));
dvdu_top = [2*dvdu_top(1)-dvdu_top(2);dvdu_top;2*dvdu_top(hang-N_le_top-1)-dvdu_top(hang-N_le_top-2)] ; 
d2vdu2_top = weifen(dvdu_top,uv_top_r(N_le_top:hang,1));
d2vdu2_top = [2*d2vdu2_top(1)-d2vdu2_top(2);d2vdu2_top;2*d2vdu2_top(hang-N_le_top-1)-d2vdu2_top(hang-N_le_top-2)] ; 
d3vdu3_top = weifen(d2vdu2_top,uv_top_r(N_le_top:hang,1));
d3vdu3_top = [2*d3vdu3_top(1)-d3vdu3_top(2);d3vdu3_top;2*d3vdu3_top(hang-N_le_top-1)-d3vdu3_top(hang-N_le_top-2)] ; 

[hang,~] = size(uv_bot) ;
dvdu_bot = weifen(uv_bot_r(N_le_bot:hang,2),uv_bot_r(N_le_bot:hang,1));
dvdu_bot = [2*dvdu_bot(1)-dvdu_bot(2);dvdu_bot;2*dvdu_bot(hang-N_le_bot-1)-dvdu_bot(hang-N_le_bot-2)] ; 
d2vdu2_bot = weifen(dvdu_bot,uv_bot_r(N_le_bot:hang,1));
d2vdu2_bot = [2*d2vdu2_bot(1)-d2vdu2_bot(2);d2vdu2_bot;2*d2vdu2_bot(hang-N_le_bot-1)-d2vdu2_bot(hang-N_le_bot-2)] ; 
d3vdu3_bot = weifen(d2vdu2_bot,uv_bot_r(N_le_bot:hang,1));
d3vdu3_bot = [2*d3vdu3_bot(1)-d3vdu3_bot(2);d3vdu3_bot;2*d3vdu3_bot(hang-N_le_bot-1)-d3vdu3_bot(hang-N_le_bot-2)] ; 

%��Ȼ��Ϳ�ʼ����һ�ѷ����ˣ���ε�δ֪�����治����Щ���߰���Ķ�����

yichuan = [1/24 11/24 11/24 1/24] ; 
yichuanp = [-1/6 -1/2 1/2 1/6] ; 
yichuanpp = [1/2 -1/2 -1/2 1/2] ;
yichuanppp = [-1 3 -3 1] ; 
% yichuanpppp = [1 -4 6 -4 1];
P1 = uv_top_r(N_le_top,1:2) ; %���
P2 =  uv_bot_r(N_le_bot,1:2) ; %�յ�
P3 =  [uinle-((P1(1,1)+P2(1,1))/2 - lethk*xishu) , (P1(1,2)+P2(1,2))/2] ; %ǰԵ�Ǹ��㡣
huatu2([P1;P3;P2]);
% k1 = (uv_top_r(N_le_top,2)-uv_top_r(N_le_top-1,2))/...
%     (uv_top_r(N_le_top,1)-uv_top_r(N_le_top-1,1)); 
k1 = dvdu_top(1) ; 
% huatu2([P1 ; P1(1,1)-1 , P1(1,2)-k1]);
% k2 = (uv_bot_r(N_le_bot,2)-uv_bot_r(N_le_bot-1,2))/...
%     (uv_bot_r(N_le_bot,1)-uv_bot_r(N_le_bot-1,1)); 
k2 = dvdu_bot(1) ; 
kk1 = d2vdu2_top(1) ; 
kk2 = d2vdu2_bot(1) ; 

kkk1 = d3vdu3_top(1) ; 
kkk2 = d3vdu3_bot(1) ; 

A_uv = [yichuan 0 0 , zeros(1,6) ;...
        zeros(1,6) , yichuan 0 0 ;...
        0 0 yichuan , zeros(1,6) ;...
        zeros(1,6) , 0 0 yichuan;...
        0 yichuan 0 , zeros(1,6) ;...
        zeros(1,6) , 0 yichuan 0;...
        
        k1*[yichuanp , 0 0] , -1*[yichuanp , 0 0];...
        k2*[0 0, yichuanp ] , -1*[0 0, yichuanp];...
        kk1*[yichuanpp , 0 0] , -1*[yichuanpp , 0 0];...
        kk2*[0 0, yichuanpp ] , -1*[0 0, yichuanpp];...
        kkk1*[yichuanppp , 0 0] , -1*[yichuanppp , 0 0];...
        kkk2*[0 0, yichuanppp ] , -1*[0 0, yichuanppp];...
        ] ;
b_uv = [P1(1,1),P1(1,2),P2(1,1),P2(1,2),P3(1,1),P3(1,2),0,0,0,0,0,0]' ; 

% % [uv_top2 , uv_bot2] = get_qianyuan3(uv_top,uv_top(:,3) ,uv_bot,uv_bot(:,3),lethk ,chi_in ,1) ;
jie_le = A_uv\b_uv ; 
dianshu = 6 ; 
Pcp_le = [jie_le(1:dianshu,1) jie_le(dianshu+1:dianshu*2,1)] ; 
qianyuan = yangtiao4(Pcp_le(1:dianshu,:) , t);
plot(uv_top_r(:,1) , uv_top_r(:,2)) ; 
plot(uv_bot_r(:,1) , uv_bot_r(:,2)) ; 
%Ȼ��Ҫ����һ�£��γ�ͳһ������uv��
uv_top_r2 = [flipud(qianyuan(1:(dianshu-4)*5+3 , :)) ; uv_top_r(N_le_top:hang ,:)] ; 
uv_bot_r2 = [qianyuan((dianshu-4)*5-3:(dianshu-4)*11 , :) ; uv_bot_r(N_le_bot:hang,:)] ; 

uv_top2 = xuanzhuan(uv_top_r2(:,1:2),chi_in);%��r��ǵ�����ת֮�������ϵ�ġ�
uv_bot2 = xuanzhuan(uv_bot_r2(:,1:2),chi_in);% ������Ū����֮����ת��ȥ�ˡ�

end


function [zhi1,zhi2] = chaxun2(uv,flag)
%����Ūһ����ѯ�ģ�����flag�����һ����Ϊ���Ӧ��uvֵ
[hang lie] = size(uv) ; 
for i=1:hang 
    if(flag(i,1) >0)
        zhi1 = [uv(i,1) uv(i,2)] ; 
        zhi2 = i ; 
        return ; 
    end
end
fprintf('���ˣ�û�ж�Ӧ�ĵ�') ;
zhi = [ 0 0 ;];
end

function zhi = xuanzhuan(dian , theta)
%�����������������ת�Ķ�����
%���ճ����Ƕ�����ʱ��Ϊ����

juzheng = [cos(theta) -sin(theta) ;...
           sin(theta) cos(theta) ];
zhi = (juzheng * dian')' ; 

if(1)
    figure(1)
    hold on ; 
    plot(dian(:,1),dian(:,2)) ; 
    plot(zhi(:,1),zhi(:,2)) ; 
    axis('equal') ; 
    grid on ; 
    hold off ; 
end

end