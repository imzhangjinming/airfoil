function [uv_top2,uv_bot2] = get_qianyuan2(uv_top,flag_top ,uv_bot,flag_bot,lethk ,chi_in ,...
    ee,ss,xcp4,ycp4,xcp6,ycp6)
%这个是输入上下两条线以及别的一应需要之物，然后输出整合好的上下两条线。
%文献里面的样条那个完全没有稳定性，还是重新弄一个多项式的算了。
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
N_le_top = 1 ; 
N_le_bot = 1 ;
uv_le_r = xuanzhuan([uv_le_top ;uv_le_bot],-chi_in);

uv_top_r = xuanzhuan(uv_top(:,1:2),-chi_in);%带r标记的是旋转之后的坐标系的。
uv_bot_r = xuanzhuan(uv_bot(:,1:2),-chi_in);

% 保持了一些通用性，不然的话直接九十度其实应该也行。

xyzS1 = uv_top_r(N_le_top,:) ; 
xyzS2 = uv_bot_r(N_le_bot,:) ; 
uv_yuanxin = (xyzS1+xyzS2)/2 ; 
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
fenjie = round(hang2/2) ; 
uv_top_r2 = [flipud(qianyuan(1:fenjie , :)) ; uv_top_r(N_le_top:hang ,:)] ; 
uv_bot_r2 = [qianyuan(fenjie:hang2 , :) ; uv_bot_r(N_le_bot:hang3,:)] ; 
% 
uv_top2 = xuanzhuan(uv_top_r2(:,1:2),chi_in);%带r标记的是旋转之后的坐标系的。
uv_bot2 = xuanzhuan(uv_bot_r2(:,1:2),chi_in);% 这里是弄好了之后再转回去了。

end

 function zhi = sanjievu(uv)
 %继续，他的公式还是尊重一手，算算看看。
 %这个是用来求d3v/du3的，抄一波书上的公式可也。
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
%这个是用来求d2v/du2的，抄一波书上的公式可也。
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
% 经过测试，这个是他那个不对。已改

zhi = d2vdu2 ; 
% zhi = duibi(1) ; 

end

function zhi = yijievu(uv)
%这个是用来求dv/du的，抄一波书上的公式可也。
[hang lie] = size(uv) ; 
u = uv(:,1) ; 
v = uv(:,2) ; 
h = (u(7) - u(1))/6 ; 
dvdu = (-49/20 *v(1) + 6*v(2) - 15/2*v(3) + 20/3*v(4) -15/4*v(5) ...
    +6/5*v(6) -1/6*v(7) ) / h ; 
% duibi = weifen(v,u) ; 
% duibi = [(2*duibi(1,:) -duibi(2,:));duibi;(2*duibi(hang-2,:)-duibi(hang-3,:))] ;
% %经过对比，似乎差的不多，因此可以认为他的那个和我认为的这个是同一个的东西。
zhi = dvdu ; 
end

function zhi = chachong(uv)
% 这个的说法在于把一个系列里面的重复的点去掉。
[hang , lie ] = size(uv) ; 
    for i = 2:hang-5
        if(sum(abs((uv(i,:) - uv(i-1 ,:))))<0.000001)
            uv(i,:) = [] ; %手动把重复的点删了嗷。
            [hang , lie ] = size(uv) ; 
        end
    end
    zhi = uv ; 
end

function zhi = qulv(uv)
%直接返回一波同样是这一列u上放着的曲率可也。两边一阶插值安排下？
[hang , lie ] = size(uv) ; 
for i = 2:hang-5
    if(sum(abs((uv(i,:) - uv(i-1 ,:))))<0.001)
        uv(i,:) = [] ; %手动把重复的点删了嗷。
        [hang , lie ] = size(uv) ; 
    end
end

uvp = weifen(uv(:,2),uv(:,1)) ;%这东西好像不怎么靠谱，会出很多NaN。
% 然而出NaN是因为样条直接连出来的点就是有重复的。
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
zhi = [ 0 0 ;];
end

function zhi = xuanzhuan(dian , theta)
%这个就是最纯粹的坐标旋转的东西。
%按照常理，角度是逆时针为正。

juzheng = [cos(theta) -sin(theta) ;...
           sin(theta) cos(theta) ];
zhi = (juzheng * dian')' ; 

if(0)
    figure(1)
    hold on ; 
    plot(dian(:,1),dian(:,2)) ; 
    plot(zhi(:,1),zhi(:,2)) ; 
    axis('equal') ; 
    grid on ; 
    hold off ; 
end

end