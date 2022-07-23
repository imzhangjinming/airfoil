function [qianyuan,qianyuan_d,qianyuan_d2]= search_Bspline4_2seg(x1 , y1 , x2 , y2,...
    dy1dx ,d2y1dx2,d3y1dx3,dy2dx,d2y2dx2 ,d3y2dx3,xzhong,yzhong,uv_top_r,uv_bot_r) 
%�����Ūһ����ν�����������ģ���ͼ��ɡ���֤����Ķ������ס�֮Ŀ��

d_step = 0.035 ;
[qianyuan,qianyuan_d,qianyuan_d2] = buquan_Bspline4_2seg_withd(x1 , y1 , x2 , y2,...
    dy1dx ,d2y1dx2,d3y1dx3,dy2dx,d2y2dx2 ,d3y2dx3,xzhong,yzhong)  ;
panju_2 = panju2(uv_top_r,uv_bot_r,qianyuan,qianyuan_d,qianyuan_d2);
fprintf('\nMXairfoil: ��Ĭ�ϵĸ߽׵�����ʱ���о�2ȡֵ��%f \n',panju_2) ; 

N = 100;%����һ�������޶
n = 1 ; 

d3ydx3_8gua = zeros(8,2) ;
panju2_8gua = zeros(8,1) ;

while(panju_2>10)
    fprintf('MXairfoil: �����������ţ���ǰ��%d��,�о�2ȡֵ��%f\n',n,panju_2);
    %��֮���������֮��
%     d3ydx3_8gua = zeros(8,2) ;
%     panju2_8gua = zeros(8,1) ;
    %Ǭ
%     d3y1dx3_111 = d3y1dx3 + 0 ;
    d3ydx3_8gua(1,1) = d3y1dx3 + 0 ;
    d3ydx3_8gua(1,2) = d3y2dx3  + d_step*n ; 
    
    %��
    d3ydx3_8gua(2,1) = d3y1dx3 + d_step/sqrt(2)*n ; 
    d3ydx3_8gua(2,2) = d3y2dx3 + d_step/sqrt(2)*n ; 
    
    %��
    d3ydx3_8gua(3,1) = d3y1dx3 + d_step*n ; 
    d3ydx3_8gua(3,2) = d3y2dx3 + 0 ; 
    
    %��
    d3ydx3_8gua(4,1) = d3y1dx3 + d_step/sqrt(2)*n ; 
    d3ydx3_8gua(4,2) = d3y2dx3 - d_step/sqrt(2)*n ;     
    
    %��
    d3ydx3_8gua(5,1) = d3y1dx3  ; 
    d3ydx3_8gua(5,2) = d3y2dx3 - d_step*n ;     
    
    %��
    d3ydx3_8gua(6,1) = d3y1dx3 - d_step/sqrt(2)*n ; 
    d3ydx3_8gua(6,2) = d3y2dx3 - d_step/sqrt(2)*n ;        
    
    %��
    d3ydx3_8gua(7,1) = d3y1dx3 - d_step*n ;     
    d3ydx3_8gua(7,2) = d3y2dx3 ;
    
    %��
    d3ydx3_8gua(8,1) = d3y1dx3 - d_step/sqrt(2)*n ; 
    d3ydx3_8gua(8,2) = d3y2dx3 + d_step/sqrt(2)*n ;  
    
    %���������λ���о�2��ֵ
    for i=1:8
        [qianyuan,qianyuan_d,qianyuan_d2] = buquan_Bspline4_2seg_withd(x1 , y1 , x2 , y2,...
    dy1dx ,d2y1dx2,d3ydx3_8gua(i,1),dy2dx,d2y2dx2 ,d3ydx3_8gua(i,2),xzhong,yzhong)  ;
%         qianyuan = chachong2(qianyuan) ; 
%         qianyuan_d = chachong2(qianyuan_d) ; 
%         qianyuan_d2 = chachong2(qianyuan_d2) ; 
        qianyuan(101,:) = [] ;
        qianyuan_d(101,:) = [] ;
        qianyuan_d2(101,:) = [] ;
        panju2_8gua(i,1)=panju2(uv_top_r,uv_bot_r,qianyuan,qianyuan_d,qianyuan_d2);
%         huatu2(qianyuan) ;
    end
    
    %�����ܵ��о�2��ֵ��
%     panju_2 = min(panju2_8gua) ; 
%     huatu2([d3ydx3_8gua;d3ydx3_8gua(1,:)]) ; 
    panju2_paixu = sort(panju2_8gua) ; 
    panju_2 = panju2_paixu(2) ; %��һ�ֹ���ϡ��õڶ�С�ġ�
%     huatu2(qianyuan) ; 

    %����һ����Щ��������ɱȽ��ݶ��½��������֡�
    weizhi = find(panju2_8gua==panju_2) ; 
    d3y1dx3 = d3ydx3_8gua(weizhi(1),1);
    d3y2dx3 = d3ydx3_8gua(weizhi(1),2);
    
    n=n+1 ; 
    if(n>N)
        panju_2=0;
        fprintf('MXairfoil: �������Ҷ���ʱ�������� \n');
    end
end

%�ҳ�ʹ��ѭ���˳�����ȷ�����������������һ�顣
i = find(panju2_8gua==panju_2) ; 
if(panju_2==0)%˵�����쳣�˳�����������Ļ�i���ǿ��˾������ˡ�
    i=find(panju2_8gua==min(panju2_8gua)) ; 
end

% ��ʹ����ǰ���Ǹ���Ҳ���ǻ��п�i���ر����ò�ͬ�Ĳ��Ե�ʱ��������úõذ���һ�¡�
[hang_i,lie_i] = size(i) ; 
if(hang_i*lie_i ==0)
    [hang , ~] = size(d3ydx3_8gua)  ;
    i = hang /2 ;
end
[qianyuan,qianyuan_d,qianyuan_d2] = buquan_Bspline4_2seg_withd(x1 , y1 , x2 , y2,...
    dy1dx ,d2y1dx2,d3ydx3_8gua(i,1),dy2dx,d2y2dx2 ,d3ydx3_8gua(i,2),xzhong,yzhong)  ;

Pcp = Pcp_Bspline4_2seg_withd(x1 , y1 , x2 , y2,...
     dy1dx ,d2y1dx2,d3ydx3_8gua(i,1),dy2dx,d2y2dx2 ,d3ydx3_8gua(i,2),xzhong,yzhong)  ;
%���԰���ƽ�Ƶ�Զ��ԭ��ĵط�����,�Ա���ӽ���������������⡣
 Pcp = Pcp + 2 ; 
 t=0:0.01:1 ; 
 qianyuan_jia = yangtiao4(Pcp,t) ;
 qianyuan_jia_d = yangtiao4_d(Pcp,t) ;
 qianyuan_jia_d2 = yangtiao4_d2(Pcp,t) ;
 panju2_jia = panju2(uv_top_r+2,uv_bot_r+2,qianyuan_jia,qianyuan_jia_d,qianyuan_jia_d2);
 fprintf('\nMXairfoil: �о�2��������Ľ��Ϊ %f \n',panju2_jia) ;
 
  if(0)
      figure(1);
      hold on ;
      plot(qianyuan(:,1),qianyuan(:,2),'-r') ; 
      huatu2(uv_top_r);
      huatu2(uv_bot_r);
      huatu2([xzhong,yzhong]);
%       huatu2(qianyuan) ; 
      
      str1 = ['$$ \frac{d^3v}{du^3}\bigg|_{top}=',num2str(d3ydx3_8gua(i,1)),...
          '\quad\quad\quad\frac{d^3v}{du^3}\bigg|_{bot}=',num2str(d3ydx3_8gua(i,2)),' $$'];
      title(str1,'Interpreter','latex');
  end

% zhi = qianyuan ; 
end 