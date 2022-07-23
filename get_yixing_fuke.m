function [chi_in,chi_out,xi,vpp,vp,bili,...
    lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
    beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi]  = get_yixing_fuke(wenjianming)
%��������ϵ��������͵Ķ�����������ά�ĵ����ˡ�Ȼ��һ��Ȧ�����֡�
% �����Ŀ��������Լ��Ķ�ά��������ʱ����Ҫ����һϵ�б�����
    [circleRadius,circleCenterCoordinates,tangencyPointsS1,tangencyPointsS2,KZRetc] ...
    = duqu_fuke(wenjianming);
    %����һ�¸���������ꡣ
    xyzSP1 = [KZRetc(:,2).*sin(KZRetc(:,3)),...
        KZRetc(:,2).*cos(KZRetc(:,3)),...
        KZRetc(:,1)] ; 
    xyzSP2 = [KZRetc(:,2).*sin(KZRetc(:,4)),...
        KZRetc(:,2).*cos(KZRetc(:,4)),...
        KZRetc(:,1)] ; 
    %����һ���л��ߵ����ꡣ
    xyzCamber = (xyzSP1+xyzSP2) /2 ; 
    
    %����һ����νǰ��ԵԲ��Բ��
    xyzC3L = [circleCenterCoordinates(1,1)*sin(circleCenterCoordinates(4,1)),...
        circleCenterCoordinates(1,1)*cos(circleCenterCoordinates(4,1)),...
        circleCenterCoordinates(2,1)] ;  
    xyzC3T = [circleCenterCoordinates(1,2)*sin(circleCenterCoordinates(4,2)),...
        circleCenterCoordinates(1,2)*cos(circleCenterCoordinates(4,2)),...
        circleCenterCoordinates(2,2)] ;  
    
    %����һ����ν�е��λ�á�
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
    %Ȼ����ǰ���һ��ǰ��Ե�������ˣ�����������������Բ��ǰ��Ե
%     RL = norm(xyzTPL1-xyzTPL2 , 2)/2 ; 
%  %���������İ뾶�������Ǹ��ƺ���һ�µġ������е㲢����Բ��Ҳ�����У������ס�
%     RL = circleRadius(1,1) ; 
    %��רҵ���������������ǰ��Ե�����ɰɡ�
    xyzYuanL = get_circleEdge(xyzC3L,xyzTPL1,xyzTPL2,circleRadius(1,1)) ; 
    xyzYuanT = get_circleEdge(xyzC3T,xyzTPT2,xyzTPT1,circleRadius(1,2)) ;
    
    %Ȼ����һ��������ֱ�ӿ��������άҶ����໡�
    flagSP1 = (xyzSP1(:,3)>xyzTPL1(3))&(xyzSP1(:,3)<xyzTPT1(3)) ; 
    flagSP2 = (xyzSP2(:,3)>xyzTPL2(3))&(xyzSP2(:,3)<xyzTPT2(3)) ; 
    
    yixing = [xyzYuanL ;...
        xyzSP1(flagSP1,:) ; ...
        xyzYuanT ; ...
        flipud(xyzSP2(flagSP2,:)) ;...
        xyzYuanL(1,:)
        ] ; 
%     huatu ; 




%Ȼ��ʼ������Щ�Ƕȡ�
    yixing_uv = [yixing(:,3),yixing(:,1)] ; 
    beta_in = KZRetc(1,6)/180*pi ; 
    beta_out = KZRetc(35,6)/180*pi ; 
%     yixing_uv = xuanzhuan(yixing_uv,-beta_in) ; 
% %     zhi = yixing ;
    %������Ȼ��Ҫ��һ��stagger angle��
    uv_C3T = [xyzC3T(:,3),xyzC3T(:,1)] ; 
    uv_C3L = [xyzC3L(:,3),xyzC3L(:,1)] ; 
    uv_camber = [xyzCamber(:,3) , xyzCamber(:,1)] ; 
    
    chord = uv_C3T - uv_C3L ; 
%     bili = norm(chord,1) ; 
    xi = atan(chord(1,2)/chord(1,1)) ; 
    yixing_uv = xuanzhuan(yixing_uv,-xi) ;
    bili = max(yixing_uv(:,1)) - min(yixing_uv(:,1));
    L_pingyi = min(yixing_uv(:,1)) ; %����ǰ���һ����Щ�����뿪���ľ��롣
    uv_camber = xuanzhuan(uv_camber,-xi) ;
    uv_camber(:,1) = uv_camber(:,1) - L_pingyi ;
    %Ȼ��������Ǽ����Ƕ�Ҳ����������ˡ�
    chi_in = beta_in - xi ; 
    chi_out = beta_out - xi ; 
    %Ȼ����һ���л��ߵ�΢���ˡ�
    uv_camber = uv_camber/bili ; %������ǲ���͵������Ȼ����ȫ�����ԣ���������ʵ���� 
    uv_camberp = weifen_uv(uv_camber) ; 
    uv_camberpp = weifen_uv(uv_camberp) ; 
%     uv_camber2 = jifen(uv_camberpp) ;
%     uv_camber2(:,2) = uv_camber2(:,2)+uv_camberp(1,2) ;%�������΢��һ�»��ֵĳ�ֵ

    [hang3 ,~] = size(uv_camber) ; 
    chi_in = atan(uv_camberp(1,2) ) ;%�յ����������Ӧ���Ǻ�������Ǹ�������һ�µġ�
    chi_out = atan(uv_camberp(hang3,2) ) ; 
    
%     uv_camber2(:,2) = uv_camber2(:,2)+tan(chi_in);
%     uv_camber2 = jifen(uv_camber2) ;
%     uv_camber2(:,2) = uv_camber2(:,2)+uv_camber(1,2) ;%�������΢��һ�»��ֵĳ�ֵ
    vpp = uv_camberpp ; 
    vp = uv_camberp;
    
        
    %����һ��ƽ�Ƶ����������������Ϊ�����л��߲���0��ʼ��������Ҫ����һ����������
    H_pingyi = min(uv_camber(:,2));
    L_pingyi = L_pingyi/bili ; 
    %Ȼ����һ��ǰ��Ե����ر�����
    uv_yuanL = [xyzYuanL(:,3),xyzYuanL(:,1)] ; 
    uv_yuanT = [xyzYuanT(:,3),xyzYuanT(:,1)] ; 
    uv_yuanLp = weifen_uv(uv_yuanL) ; 
    uv_yuanLpp = weifen_uv(uv_yuanLp) ; 
    uv_yuanTp = weifen_uv(uv_yuanT) ; 
    uv_yuanTpp = weifen_uv(uv_yuanTp) ; 
    %��ͼֱ����֮���ù�ȥ�����ǱȽ����׵��ˡ�
%     shishi = 0:0.05:2*pi ; 
%     shishi_yuan = [cos(shishi') ,sin(shishi')] ; 
%     shishi_yuanp = weifen_uv(shishi_yuan) ; 
%     shishi_yuanpp = weifen_uv(shishi_yuanp) ; 
%     plot(shishi_yuanp(:,1),shishi_yuanp(:,2)) ; 
    % %�ðɺ���Ҳ�����ر�����
    lecurv = uv_yuanLpp(6,2) ; 
    tecurv = uv_yuanTpp(6,2) ; 
    lethk = circleRadius(1,1)*2 ; 
    tethk = circleRadius(1,2)*2 ; 
    umxthk = KZRetc(KZRetc(:,5)==max(KZRetc(:,5)),1) - L_pingyi ; 
    %�ҵ��������λ�����ڵ����У����еĵ�һ����������ȵ�λ�á�
    mxthk = KZRetc(KZRetc(:,5)==max(KZRetc(:,5)),5) ; 
    %�ٴθ�̾MATLAB�ľ������������걸����ʵ�е���á�
    
    %Ȼ�����������ȥŪ���ε��Ǹ�������
    beta_in1 = KZRetc(1,7)/180*pi;
    beta_out1 = KZRetc(35,7) /180*pi;
    
    houdu_cankao = [KZRetc(:,1) , KZRetc(:,5) ] ;

end