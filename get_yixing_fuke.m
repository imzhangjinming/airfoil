function [chi_in,chi_out,xi,vpp,vp,bili,...
    lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
    beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi]  = get_yixing_fuke(wenjianming)
%这个是整合的生成翼型的东西，生成三维的点列了。然后一整圈的那种。
% 这个的目的是输出自己的二维代码求解的时候需要的那一系列变量。
    [circleRadius,circleCenterCoordinates,tangencyPointsS1,tangencyPointsS2,KZRetc] ...
    = duqu_fuke(wenjianming);
    %安排一下各个面的坐标。
    xyzSP1 = [KZRetc(:,2).*sin(KZRetc(:,3)),...
        KZRetc(:,2).*cos(KZRetc(:,3)),...
        KZRetc(:,1)] ; 
    xyzSP2 = [KZRetc(:,2).*sin(KZRetc(:,4)),...
        KZRetc(:,2).*cos(KZRetc(:,4)),...
        KZRetc(:,1)] ; 
    %安排一下中弧线的坐标。
    xyzCamber = (xyzSP1+xyzSP2) /2 ; 
    
    %安排一下所谓前后缘圆的圆心
    xyzC3L = [circleCenterCoordinates(1,1)*sin(circleCenterCoordinates(4,1)),...
        circleCenterCoordinates(1,1)*cos(circleCenterCoordinates(4,1)),...
        circleCenterCoordinates(2,1)] ;  
    xyzC3T = [circleCenterCoordinates(1,2)*sin(circleCenterCoordinates(4,2)),...
        circleCenterCoordinates(1,2)*cos(circleCenterCoordinates(4,2)),...
        circleCenterCoordinates(2,2)] ;  
    
    %安排一下所谓切点的位置。
    xyzTPL1 = [circleCenterCoordinates(1,1)*sin(tangencyPointsS1(2,1)),...
        circleCenterCoordinates(1,1)*cos(tangencyPointsS1(2,1)),...
        tangencyPointsS1(1,1)] ; 
    xyzTPL2 = [circleCenterCoordinates(1,1)*sin(tangencyPointsS2(2,1)),...
        circleCenterCoordinates(1,1)*cos(tangencyPointsS2(2,1)),...
        tangencyPointsS2(1,1)] ; 
    xyzTPT1 = [circleCenterCoordinates(1,2)*sin(tangencyPointsS1(2,2)),...
        circleCenterCoordinates(1,2)*cos(tangencyPointsS1(2,2)),...
        tangencyPointsS1(1,2)] ; 
    xyzTPT2 = [circleCenterCoordinates(1,2)*sin(tangencyPointsS2(2,2)),...
        circleCenterCoordinates(1,2)*cos(tangencyPointsS2(2,2)),...
        tangencyPointsS2(1,2)] ;
    xiuzhengTPT = xyzC3T - (xyzTPT1+xyzTPT2)/2 ; 
    xyzTPT1 = xyzTPT1 + xiuzhengTPT ; 
    xyzTPT2 = xyzTPT2 + xiuzhengTPT ; 
    
    xiuzhengTPL = xyzC3L - (xyzTPL1+xyzTPL2)/2 ; 
    xyzTPL1 = xyzTPL1 + xiuzhengTPL ; 
    xyzTPL2 = xyzTPL2 + xiuzhengTPL ; 
    %然后就是安排一手前后缘的生成了，讲道理这就离谱这个圆的前后缘
%     RL = norm(xyzTPL1-xyzTPL2 , 2)/2 ; 
%  %这个求出来的半径和下面那个似乎是一致的。但是切点并不在圆上也不相切，就离谱。
%     RL = circleRadius(1,1) ; 
    %用专业的向量运算来完成前后缘的生成吧。
    xyzYuanL = get_circleEdge(xyzC3L,xyzTPL1,xyzTPL2,circleRadius(1,1)) ; 
    xyzYuanT = get_circleEdge(xyzC3T,xyzTPT2,xyzTPT1,circleRadius(1,2)) ;
    
    %然后安排一手整理，就直接可以输出二维叶形了嗷。
    flagSP1 = (xyzSP1(:,3)>xyzTPL1(3))&(xyzSP1(:,3)<xyzTPT1(3)) ; 
    flagSP2 = (xyzSP2(:,3)>xyzTPL2(3))&(xyzSP2(:,3)<xyzTPT2(3)) ; 
    
    yixing = [xyzYuanL ;...
        xyzSP1(flagSP1,:) ; ...
        xyzYuanT ; ...
        flipud(xyzSP2(flagSP2,:)) ;...
        xyzYuanL(1,:)
        ] ; 
%     huatu ; 




%然后开始安排那些角度。
    yixing_uv = [yixing(:,3),yixing(:,1)] ; 
    beta_in = KZRetc(1,6)/180*pi ; 
    beta_out = KZRetc(35,6)/180*pi ; 
%     yixing_uv = xuanzhuan(yixing_uv,-beta_in) ; 
% %     zhi = yixing ;
    %首先显然是要求一下stagger angle。
    uv_C3T = [xyzC3T(:,3),xyzC3T(:,1)] ; 
    uv_C3L = [xyzC3L(:,3),xyzC3L(:,1)] ; 
    uv_camber = [xyzCamber(:,3) , xyzCamber(:,1)] ; 
    
    chord = uv_C3T - uv_C3L ; 
%     bili = norm(chord,1) ; 
    xi = atan(chord(1,2)/chord(1,1)) ; 
    yixing_uv = xuanzhuan(yixing_uv,-xi) ;
    bili = max(yixing_uv(:,1)) - min(yixing_uv(:,1));
    L_pingyi = min(yixing_uv(:,1)) ; %这个是安排一手这些东西离开零点的距离。
    uv_camber = xuanzhuan(uv_camber,-xi) ;
    uv_camber(:,1) = uv_camber(:,1) - L_pingyi ;
    %然后另外的那几个角度也就容易求得了。
    chi_in = beta_in - xi ; 
    chi_out = beta_out - xi ; 
    %然后处理一下中弧线的微分了。
    uv_camber = uv_camber/bili ; %这个还是不能偷懒，不然后面全都不对，就尼玛属实离谱 
    uv_camberp = weifen_uv(uv_camber) ; 
    uv_camberpp = weifen_uv(uv_camberp) ; 
%     uv_camber2 = jifen(uv_camberpp) ;
%     uv_camber2(:,2) = uv_camber2(:,2)+uv_camberp(1,2) ;%这个是稍微修一下积分的初值

    [hang3 ,~] = size(uv_camber) ; 
    chi_in = atan(uv_camberp(1,2) ) ;%照道理这个定义应该是和上面的那个定义是一致的。
    chi_out = atan(uv_camberp(hang3,2) ) ; 
    
%     uv_camber2(:,2) = uv_camber2(:,2)+tan(chi_in);
%     uv_camber2 = jifen(uv_camber2) ;
%     uv_camber2(:,2) = uv_camber2(:,2)+uv_camber(1,2) ;%这个是稍微修一下积分的初值
    vpp = uv_camberpp ; 
    vp = uv_camberp;
    
        
    %安排一下平移的修正量。这个是因为它的中弧线不从0开始，所以需要安排一手修正量。
    H_pingyi = min(uv_camber(:,2));
    L_pingyi = L_pingyi/bili ; 
    %然后安排一下前后缘的相关变量。
    uv_yuanL = [xyzYuanL(:,3),xyzYuanL(:,1)] ; 
    uv_yuanT = [xyzYuanT(:,3),xyzYuanT(:,1)] ; 
    uv_yuanLp = weifen_uv(uv_yuanL) ; 
    uv_yuanLpp = weifen_uv(uv_yuanLp) ; 
    uv_yuanTp = weifen_uv(uv_yuanT) ; 
    uv_yuanTpp = weifen_uv(uv_yuanTp) ; 
    %试图直接求导之后拿过去恐怕是比较离谱的了。
%     shishi = 0:0.05:2*pi ; 
%     shishi_yuan = [cos(shishi') ,sin(shishi')] ; 
%     shishi_yuanp = weifen_uv(shishi_yuan) ; 
%     shishi_yuanpp = weifen_uv(shishi_yuanp) ; 
%     plot(shishi_yuanp(:,1),shishi_yuanp(:,2)) ; 
    % %好吧好像也不是特别离谱
    lecurv = uv_yuanLpp(6,2) ; 
    tecurv = uv_yuanTpp(6,2) ; 
    lethk = circleRadius(1,1)*2 ; 
    tethk = circleRadius(1,2)*2 ; 
    umxthk = KZRetc(KZRetc(:,5)==max(KZRetc(:,5)),1) - L_pingyi ; 
    %找到厚度最大的位置所在的那行，那行的第一个乃是最大厚度的位置。
    mxthk = KZRetc(KZRetc(:,5)==max(KZRetc(:,5)),5) ; 
    %再次感叹MATLAB的矩阵相关运算的完备。属实有点好用。
    
    %然后是用于配合去弄三次的那个东西。
    beta_in1 = KZRetc(1,7)/180*pi;
    beta_out1 = KZRetc(35,7) /180*pi;
    
    houdu_cankao = [KZRetc(:,1) , KZRetc(:,5) ] ;

end