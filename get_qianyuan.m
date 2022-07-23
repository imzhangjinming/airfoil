function [uv_top2,uv_bot2] = get_qianyuan(uv_top,flag_top ,uv_bot,flag_bot,lethk ,chi_in ,...
    ee,ss,xcp4,ycp4,xcp6,ycp6)
%��������������������Լ����һӦ��Ҫ֮�Ȼ��������Ϻõ����������ߡ�
% fendu = 0.025 ; 
% lethk = 0.15*2*fendu ; 
% tethk = 0.1*2*fendu ; 
% umxthk = 0.3 ; 
% mxthk = 0.4*fendu*2 ; 
t = 0:0.1:1 ; 
% flag_top = uv_top(:,2:4) ; 
% flag_bot = uv_bot(:,2:4) ; 
uv_top = chachong(uv_top) ; 
uv_bot = chachong(uv_bot) ; 
[hang lie] = size(uv_top) ;

[uv_le_top ,N_le_top] = chaxun2(uv_top,flag_top) ;
[uv_le_bot ,N_le_bot] = chaxun2(uv_bot,flag_bot) ;
uv_le_r = xuanzhuan([uv_le_top ;uv_le_bot],-chi_in);
% xuanzhuan(v,-chi_in);

% Ȼ�������Ƶ㡣
%����漰����̫�࣬�ڶ���֮ǰר��Ūһ������������ڡ�
uv_top_r = xuanzhuan(uv_top(:,1:2),-chi_in);%��r��ǵ�����ת֮�������ϵ�ġ�
uv_bot_r = xuanzhuan(uv_bot(:,1:2),-chi_in);
C_le_top = qulv(uv_top_r) ; 
C_le_bot = qulv(uv_bot_r) ; 

uinle = 1/2*(uv_le_r(1,1)+uv_le_r(2,1)) ; %����������������ƽ��һ�������������ʵô�õ�һ��Ҳ�С�
% chrdle = lethk*12 ; %����ų���ǰԵ���ҳ���
chrdle = lethk*ee ; %����ų���ǰԵ���ҳ���
% ss = 0.01 ;
u_le_tip = uinle - chrdle ; 
v_le_tip = ss * chrdle ; 
% figure() %�����Ҫ��Ϊ�˿�һ��ǰԵ�����λ����������λ�ò�Ӧ��̫���ס�
% hold on ; 
% plot(uv_top_r(:,1) , uv_top_r(:,2)) ; 
% plot(uv_bot_r(:,1) , uv_bot_r(:,2)) ; 
% plot(u_le_tip ,v_le_tip,'*');
% axis('equal') ;
% grid on ; 
% hold off ;

%Ȼ���Ǵ���һ����һ��΢�֡�
dvdu_top = yijievu(uv_top_r(N_le_top:hang,1:2)) ; 
dvdu_bot = yijievu(uv_bot_r(N_le_bot:hang,1:2)) ;
d2vdu2_top = erjievu(uv_top_r(N_le_top:hang,1:2)) ; 
d2vdu2_bot = erjievu(uv_bot_r(N_le_bot:hang,1:2)) ; 
d3vdu3_top = sanjievu(uv_top_r(N_le_top:hang,1:2)) ; 
d3vdu3_bot = sanjievu(uv_bot_r(N_le_bot:hang,1:2)) ; 

%���������ú�������һ��
%  y = @(x) 0*x.^3 + 1*x.^2 + 0*x ; 
%  x_shishi = 1:0.1:2 ; 
%  y_shishi = y(x_shishi) ; 
%  xy_shishi = [x_shishi' , y_shishi'] ; 
% %  dvdu_shishi = yijievu(xy_shishi) ; %����Ѿ�ͨ�����ԡ�
%  d2vdu2_shishi = erjievu(xy_shishi) ; %������������������Ǹ����ԡ��Ѹ�
% %  d3vdu3_shishi = sanjievu(xy_shishi) ;
% %  %�����ͨ�����ԡ������ҵ�΢�ֵı�Ե��ֵ���������ֳ����ˡ�ֻ��һ�ף����Ա�Ե����Ƕ��׵ľͻ�����
 
%��Ȼ��Ϳ�ʼ����һ�ѷ����ˣ���ε�δ֪�����治����Щ���߰���Ķ�����
% xcp4 = 0.4 ;   
% ycp4 = 0.4 ; 
% xcp6 = 0.8 ; 
% ycp6 = 1.6 ; 

yichuan = [1/24 11/24 11/24 1/24] ; 
yichuanp = [-1/6 -1/2 1/2 1/6] ; 
yichuanpp = [1/2 -1/2 -1/2 1/2] ;
yichuanppp = [-1 3 -3 1] ; 
% yichuanpppp = [1 -4 6 -4 1];
A_le = [yichuan zeros(1,5) , zeros(1,9) ;...
        zeros(1,9) , yichuan zeros(1,5) ;...
        0 0 0 0 0 yichuan  ,zeros(1,9) ; ...
        zeros(1,9) , 0 0 0 0 0 yichuan ; ...
        
        dvdu_top*yichuanp zeros(1,5) , -1*yichuanp zeros(1,5) ;...
        zeros(1,5) dvdu_bot*yichuanp , zeros(1,5) -1*yichuanp ;...
        d2vdu2_top*yichuanpp zeros(1,5) , -1*yichuanpp zeros(1,5) ;...
        zeros(1,5) d2vdu2_bot*yichuanpp , zeros(1,5) -1*yichuanpp ;...
        d3vdu3_top*yichuanppp zeros(1,5) , -1*yichuanppp zeros(1,5);...
        zeros(1,5) d3vdu3_bot*yichuanppp , zeros(1,5) -1*yichuanppp;...
        
        zeros(1,9) , 0 C_le_top(N_le_top,2) -1 (1-C_le_top(N_le_top,2)) zeros(1,5) ;...
        zeros(1,9) , zeros(1,5) (1-C_le_bot(N_le_bot,2)) -1 C_le_bot(N_le_bot,2) 0 ;...
        
        0 0 1/384 19/96 115/192 19/96 1/384 0 0 ,zeros(1,9);...
        zeros(1,9) , 0 0 1/384 19/96 115/192 19/96 1/384 0 0;...
        
%         0 0 -1/48 -11/24 0 9/24 1/48 0 0 ,zeros(1,9);...
%         zeros(1,9) , 0 0 -1/48 -11/24 0 9/24 1/48 0 0;...        
        
        0 0 0 1 zeros(1,5) , zeros(1,9) ;...
        zeros(1,9) , 0 0 0 1 zeros(1,5) ;...
        zeros(1,5) 1 0 0 0 , zeros(1,9) ;...
        zeros(1,9) , zeros(1,5) 1 0 0 0 ;...
        ];
b_le = [uv_le_r(1,1) uv_le_r(1,2) uv_le_r(2,1) uv_le_r(2,2) ,...
        zeros(1,6) ,...
        0 0 ,...
        u_le_tip  v_le_tip ,...
        (1-xcp4)*(uinle - u_le_tip) ,ycp4*(lethk/2 - v_le_tip) ,...
        (1-xcp6)*( - uinle + u_le_tip) ,ycp6*( - lethk/2 + v_le_tip) ...
        ]' ; 

jie_le = A_le\b_le ; 
Pcp_le = [jie_le(1:9,1) jie_le(10:18,1)] ; 
qianyuan = yangtiao4(Pcp_le(1:9,:) , t);
plot(uv_top_r(:,1) , uv_top_r(:,2)) ; 
plot(uv_bot_r(:,1) , uv_bot_r(:,2)) ; 
plot(u_le_tip ,v_le_tip,'*');
%Ȼ��Ҫ����һ�£��γ�ͳһ������uv��
uv_top_r2 = [flipud(qianyuan(1:30 , :)) ; uv_top_r(N_le_top:hang ,:)] ; 
uv_bot_r2 = [qianyuan(25:55 , :) ; uv_bot_r(N_le_bot:hang,:)] ; 
% plot(uv_top_r2(:,1) , uv_top_r2(: ,2)) ; 
% hold on
% plot(uv_bot_r2(:,1) , uv_bot_r2(:,2)) ; 

uv_top2 = xuanzhuan(uv_top_r2(:,1:2),chi_in);%��r��ǵ�����ת֮�������ϵ�ġ�
uv_bot2 = xuanzhuan(uv_bot_r2(:,1:2),chi_in);% ������Ū����֮����ת��ȥ�ˡ�
% plot(uv_top2(:,1) , uv_top2(: ,2)) ; 
% hold on
% plot(uv_bot2(:,1) , uv_bot2(:,2)) ; 
% axis('equal') ; 

end

 function zhi = sanjievu(uv)
 %���������Ĺ�ʽ��������һ�֣����㿴����
 %�����������d3v/du3�ģ���һ�����ϵĹ�ʽ��Ҳ��
[hang lie] = size(uv) ; 
u = uv(:,1) ; 
v = uv(:,2) ; 
h = (u(7) - u(1))/6 ; 
d3vdu3 = (-49/8 *v(1) + 29*v(2) - 461/8*v(3) + 62*v(4) -307/8*v(5) ...
    +13*v(6) -15/8*v(7) ) / (h^3) ;

% duibi = weifen(v,u) ; 
% duibi = [(2*duibi(1,:) -duibi(2,:));duibi;(2*duibi(hang-2,:)-duibi(hang-3,:))] ;
% duibi = weifen(duibi,u) ; 
% duibi = [(2*duibi(1,:) -duibi(2,:));duibi;(2*duibi(hang-2,:)-duibi(hang-3,:))] ;
% duibi = weifen(duibi,u) ; 
% duibi = [(2*duibi(1,:) -duibi(2,:));duibi;(2*duibi(hang-2,:)-duibi(hang-3,:))] ;

zhi = d3vdu3 ; 
 end

function zhi = erjievu(uv)
%�����������d2v/du2�ģ���һ�����ϵĹ�ʽ��Ҳ��
[hang lie] = size(uv) ; 
u = uv(:,1) ; 
v = uv(:,2) ; 
h = (u(7) - u(1))/6 ; 
d2vdu2 = -(-203/45 *v(1) + 87/5*v(2) - 117/4*v(3) + 254/9*v(4) -33/2*v(5) ...
    +27/5*v(6) -137/180*v(7) ) / (h^2) ;

% duibi = weifen(v,u) ; 
% duibi = [(2*duibi(1,:) -duibi(2,:));duibi;(2*duibi(hang-2,:)-duibi(hang-3,:))] ;
% duibi = weifen(duibi,u) ; 
% duibi = [(2*duibi(1,:) -duibi(2,:));duibi;(2*duibi(hang-2,:)-duibi(hang-3,:))] ;
% �������ԣ���������Ǹ����ԡ��Ѹ�

zhi = d2vdu2 ; 
% zhi = duibi(1) ; 

end

function zhi = yijievu(uv)
%�����������dv/du�ģ���һ�����ϵĹ�ʽ��Ҳ��
[hang lie] = size(uv) ; 
u = uv(:,1) ; 
v = uv(:,2) ; 
h = (u(7) - u(1))/6 ; 
dvdu = (-49/20 *v(1) + 6*v(2) - 15/2*v(3) + 20/3*v(4) -15/4*v(5) ...
    +6/5*v(6) -1/6*v(7) ) / h ; 
% duibi = weifen(v,u) ; 
% duibi = [(2*duibi(1,:) -duibi(2,:));duibi;(2*duibi(hang-2,:)-duibi(hang-3,:))] ;
% %�����Աȣ��ƺ���Ĳ��࣬��˿�����Ϊ�����Ǹ�������Ϊ�������ͬһ���Ķ�����
zhi = dvdu ; 
end

function zhi = chachong(uv)
% �����˵�����ڰ�һ��ϵ��������ظ��ĵ�ȥ����
[hang , lie ] = size(uv) ; 
    for i = 2:hang-5
        if(sum(abs((uv(i,:) - uv(i-1 ,:))))<0.001)
            uv(i,:) = [] ; %�ֶ����ظ��ĵ�ɾ��໡�
            [hang , lie ] = size(uv) ; 
        end
    end
    zhi = uv ; 
end

function zhi = qulv(uv)
%ֱ�ӷ���һ��ͬ������һ��u�Ϸ��ŵ����ʿ�Ҳ������һ�ײ�ֵ�����£�
[hang , lie ] = size(uv) ; 
for i = 2:hang-5
    if(sum(abs((uv(i,:) - uv(i-1 ,:))))<0.001)
        uv(i,:) = [] ; %�ֶ����ظ��ĵ�ɾ��໡�
        [hang , lie ] = size(uv) ; 
    end
end

uvp = weifen(uv(:,2),uv(:,1)) ;%�ⶫ��������ô���ף�����ܶ�NaN��
% Ȼ����NaN����Ϊ����ֱ���������ĵ�������ظ��ġ�
uvp = [(2*uvp(1,:) -uvp(2,:));uvp;(2*uvp(hang-2,:)-uvp(hang-3,:))] ;
% uvp = (uv(2:hang,2) - uv(1:hang-1,2))./(uv(2:hang,1) - uv(1:hang-1,1)) ; 
% uvp = [uvp;(2*uvp(hang-2,:)-uvp(hang-1,:))] ;
uvpp = weifen(uvp,uv(:,1)) ; 
uvpp = [(2*uvpp(1,:) -uvpp(2,:));uvpp;(2*uvpp(hang-2,:)-uvpp(hang-3,:))] ;
% uvpp = (uvp(2:hang,1) - uvp(1:hang-1,1))./(uv(2:hang,1) - uv(1:hang-1,1)) ; 
% uvpp = [uvpp;(2*uvpp(hang-2,:)-uvpp(hang-1,:))] ;

C = uvpp(:,1)./(1 + uvp(:,1).^2).^(3/2) ; 
zhi = [uv(:,1),C] ; 
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