function [uv_top2,uv_bot2] = get_qianyuan22(uv_top,flag_top ,uv_bot,flag_bot,lethk ,chi_in ,...
    ee,ss,xcp4,ycp4,xcp6,ycp6)
%这个是输入上下两条线以及别的一应需要之物，然后输出整合好的上下两条线。
%改进的圆前缘，2021年6月27日15:36:55，至少一阶的连续性要保证的呀，不然万一是钝头的不是直接凉凉了。
% 继续改进，2021年8月2日16:14:04，现在这个搞法，N_le_bot会发散，就尼玛离大谱
% 继续改进，2021年8月3日09:46:29，修正了平行导致的前后缘飞到遥远的外面。
t = 0:0.1:1 ; 
uv_top = chachong(uv_top) ; 
uv_bot = chachong(uv_bot) ; 
[hang lie] = size(uv_top) ;

[uv_le_top ,N_le_top] = chaxun2(uv_top,flag_top) ;
[uv_le_bot ,N_le_bot] = chaxun2(uv_bot,flag_bot) ;
% N_le = round((N_le_top+N_le_top)/2) ; 
% N_le = min(N_le_top,N_le_bot) ; 
% N_le_top = N_le ; 
% N_le_bot = N_le ;
% N_le_top = 1 ; 
% N_le_bot = 1 ;
if N_le_top > 3
    N_le_top = 3 ; 
end
if N_le_bot > 3
    N_le_bot = 3 ; 
end


uv_top_r = xuanzhuan(uv_top(:,1:2),-chi_in);%带r标记的是旋转之后的坐标系的。
uv_bot_r = xuanzhuan(uv_bot(:,1:2),-chi_in);

% 保持了一些通用性，不然的话直接九十度其实应该也行。

xyzS1 = uv_top_r(N_le_top,:) ; 
xyzS2 = uv_bot_r(N_le_bot,:) ; 

i = 1 ; 
while xyzS1(2)<(xyzS2(2))
    %这个是防止两个点太接近导致切线交叉在不该出现的地方
    xyzS1 = uv_top_r(N_le_top+i,:) ; 
    xyzS2 = uv_bot_r(N_le_bot+i,:) ;
    i=i+1 ; 
end

uv_yuanxin = (xyzS1+xyzS2)/2 ; 

V1 = xyzS1 - uv_yuanxin ; 
flag1 = sign(V1(1,1)) ; 
jiaodu1 = atan(V1(1,2)/V1(1,1)) ; 
R = norm(V1,2) ; 

% 重新，搞一个专业点的方法求圆心。
% 菜鸡我靠。正确的应该是两个切线平移一下求交点。等会儿再来弄罢。
line_top = zhixian(uv_top_r(N_le_top,:),uv_top_r(N_le_top+1,:),1) ; 
line_bot = zhixian(uv_bot_r(N_le_bot,:),uv_bot_r(N_le_bot+1,:),1) ;
uv_yuanxin2 = get_yuanxin(line_top,line_bot,R,uv_yuanxin) ; 

% 容错。如果前后缘平行的话，uv_yuanxin2就会飞到不知道哪里去。
jvli = norm(uv_yuanxin - uv_yuanxin2) ; 
if jvli<0.2 % 说明没有飞出去
    % 然后重新求上下的交点。
    line_top_chuizhi = zhixian(uv_yuanxin2,line_top,'PtoLine') ; 
    line_bot_chuizhi = zhixian(uv_yuanxin2,line_bot,'PtoLine') ; 
    xyzS1 = line_top_chuizhi.get_jiaodian(line_top) ; 
    xyzS2 = line_bot_chuizhi.get_jiaodian(line_bot) ; 

    % 然后重新求解之前的那些。并修正一下
    uv_yuanxin = uv_yuanxin2 ;
    if xyzS1(1)>uv_top_r(N_le_top,1) %这个是防止有突出去的点。
        uv_top_r(N_le_top,:) = xyzS1 ; 
        while xyzS1(1)>uv_top_r(N_le_top+1,1)
            uv_top_r(N_le_top+1,:) = xyzS1 ; 
            N_le_top = N_le_top+1 ;
            fprintf('MXairfoil: maybe something wrong. keeping live because some rongcuo \n')
        end
    end
    if xyzS2(1)>uv_bot_r(N_le_bot,1) %这个是防止有突出去的点。
        uv_bot_r(N_le_bot,:) = xyzS2 ; 
        while xyzS2(1)>uv_bot_r(N_le_bot+1,1)
            uv_bot_r(N_le_bot+1,:) = xyzS2 ; 
            N_le_bot = N_le_bot+1 ;
            fprintf('MXairfoil: maybe something wrong. keeping live because some rongcuo \n')
        end
    end
    % visualization in temp.
end


% 这里再往后理论上就没变化了。
V1 = xyzS1 - uv_yuanxin ; 
flag1 = sign(V1(1,1)) ; 
jiaodu1 = atan(V1(1,2)/V1(1,1)) ; 
R = norm(V1,2) ; 
if(flag1<0)
    jiaodu1 = jiaodu1+pi ;
end 
V2 = xyzS2 - uv_yuanxin ;
flag2 = sign(V2(1,1)) ; 
jiaodu2 = atan(V2(1,2)/V2(1,1)) ; 
if(flag2<0)
    jiaodu2 = jiaodu2-pi ;
end 

if(jiaodu1>jiaodu2)
    jiaodu1 = jiaodu1-2*pi ; 
end
canshu = jiaodu1:...
    0.1*abs(max(jiaodu1,jiaodu2)-min(jiaodu1,jiaodu2)):...
    jiaodu2 ; 
canshu = canshu' ; 
qianyuan = [uv_yuanxin(1,1)+cos(canshu).*R,uv_yuanxin(1,2)+sin(canshu).*R];


%然后要整理一下，形成统一的两组uv。
[hang2,~] = size(qianyuan) ; 
[hang3,~] = size(uv_bot_r) ; 
[hang,~] = size(uv_top_r) ;
fenjie = round(hang2/2) ; 
uv_top_r2 = [flipud(qianyuan(1:fenjie , :)) ; uv_top_r(N_le_top:hang ,:)] ; 
uv_bot_r2 = [qianyuan(fenjie:hang2 , :) ; uv_bot_r(N_le_bot:hang3,:)] ; 
% 
uv_top2 = xuanzhuan(uv_top_r2(:,1:2),chi_in);%带r标记的是旋转之后的坐标系的。
uv_bot2 = xuanzhuan(uv_bot_r2(:,1:2),chi_in);% 这里是弄好了之后再转回去了。

end

function [zhi1,zhi2] = chaxun2(uv,flag)
%单纯弄一个查询的，返回flag里面第一个不为零对应的uv值
[hang lie] = size(uv) ; 
for i=1:hang 
    if(flag(i,1) >0)
        zhi1 = [uv(i,1) uv(i,2)] ; 
        zhi2 = i ; 
        return ; 
    end
end
fprintf('凉了，没有对应的点') ;
zhi1 = [0 0] ; 
zhi2 = 0 ; 
end
