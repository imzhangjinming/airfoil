function [uv_top2,uv_bot2] = get_qianyuan22(uv_top,flag_top ,uv_bot,flag_bot,lethk ,chi_in ,...
    ee,ss,xcp4,ycp4,xcp6,ycp6)
%��������������������Լ����һӦ��Ҫ֮�Ȼ��������Ϻõ����������ߡ�
%�Ľ���ԲǰԵ��2021��6��27��15:36:55������һ�׵�������Ҫ��֤��ѽ����Ȼ��һ�Ƕ�ͷ�Ĳ���ֱ�������ˡ�
% �����Ľ���2021��8��2��16:14:04����������㷨��N_le_bot�ᷢɢ�������������
% �����Ľ���2021��8��3��09:46:29��������ƽ�е��µ�ǰ��Ե�ɵ�ңԶ�����档
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


uv_top_r = xuanzhuan(uv_top(:,1:2),-chi_in);%��r��ǵ�����ת֮�������ϵ�ġ�
uv_bot_r = xuanzhuan(uv_bot(:,1:2),-chi_in);

% ������һЩͨ���ԣ���Ȼ�Ļ�ֱ�Ӿ�ʮ����ʵӦ��Ҳ�С�

xyzS1 = uv_top_r(N_le_top,:) ; 
xyzS2 = uv_bot_r(N_le_bot,:) ; 

i = 1 ; 
while xyzS1(2)<(xyzS2(2))
    %����Ƿ�ֹ������̫�ӽ��������߽����ڲ��ó��ֵĵط�
    xyzS1 = uv_top_r(N_le_top+i,:) ; 
    xyzS2 = uv_bot_r(N_le_bot+i,:) ;
    i=i+1 ; 
end

uv_yuanxin = (xyzS1+xyzS2)/2 ; 

V1 = xyzS1 - uv_yuanxin ; 
flag1 = sign(V1(1,1)) ; 
jiaodu1 = atan(V1(1,2)/V1(1,1)) ; 
R = norm(V1,2) ; 

% ���£���һ��רҵ��ķ�����Բ�ġ�
% �˼��ҿ�����ȷ��Ӧ������������ƽ��һ���󽻵㡣�Ȼ������Ū�ա�
line_top = zhixian(uv_top_r(N_le_top,:),uv_top_r(N_le_top+1,:),1) ; 
line_bot = zhixian(uv_bot_r(N_le_bot,:),uv_bot_r(N_le_bot+1,:),1) ;
uv_yuanxin2 = get_yuanxin(line_top,line_bot,R,uv_yuanxin) ; 

% �ݴ����ǰ��Եƽ�еĻ���uv_yuanxin2�ͻ�ɵ���֪������ȥ��
jvli = norm(uv_yuanxin - uv_yuanxin2) ; 
if jvli<0.2 % ˵��û�зɳ�ȥ
    % Ȼ�����������µĽ��㡣
    line_top_chuizhi = zhixian(uv_yuanxin2,line_top,'PtoLine') ; 
    line_bot_chuizhi = zhixian(uv_yuanxin2,line_bot,'PtoLine') ; 
    xyzS1 = line_top_chuizhi.get_jiaodian(line_top) ; 
    xyzS2 = line_bot_chuizhi.get_jiaodian(line_bot) ; 

    % Ȼ���������֮ǰ����Щ��������һ��
    uv_yuanxin = uv_yuanxin2 ;
    if xyzS1(1)>uv_top_r(N_le_top,1) %����Ƿ�ֹ��ͻ��ȥ�ĵ㡣
        uv_top_r(N_le_top,:) = xyzS1 ; 
        while xyzS1(1)>uv_top_r(N_le_top+1,1)
            uv_top_r(N_le_top+1,:) = xyzS1 ; 
            N_le_top = N_le_top+1 ;
            fprintf('MXairfoil: maybe something wrong. keeping live because some rongcuo \n')
        end
    end
    if xyzS2(1)>uv_bot_r(N_le_bot,1) %����Ƿ�ֹ��ͻ��ȥ�ĵ㡣
        uv_bot_r(N_le_bot,:) = xyzS2 ; 
        while xyzS2(1)>uv_bot_r(N_le_bot+1,1)
            uv_bot_r(N_le_bot+1,:) = xyzS2 ; 
            N_le_bot = N_le_bot+1 ;
            fprintf('MXairfoil: maybe something wrong. keeping live because some rongcuo \n')
        end
    end
    % visualization in temp.
end


% ���������������Ͼ�û�仯�ˡ�
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


%Ȼ��Ҫ����һ�£��γ�ͳһ������uv��
[hang2,~] = size(qianyuan) ; 
[hang3,~] = size(uv_bot_r) ; 
[hang,~] = size(uv_top_r) ;
fenjie = round(hang2/2) ; 
uv_top_r2 = [flipud(qianyuan(1:fenjie , :)) ; uv_top_r(N_le_top:hang ,:)] ; 
uv_bot_r2 = [qianyuan(fenjie:hang2 , :) ; uv_bot_r(N_le_bot:hang3,:)] ; 
% 
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
zhi1 = [0 0] ; 
zhi2 = 0 ; 
end
