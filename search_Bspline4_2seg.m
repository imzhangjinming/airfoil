function [qianyuan,qianyuan_d,qianyuan_d2]= search_Bspline4_2seg(x1 , y1 , x2 , y2,...
    dy1dx ,d2y1dx2,d3y1dx3,dy2dx,d2y2dx2 ,d3y2dx3,xzhong,yzhong,uv_top_r,uv_bot_r) 
%这个是弄一个所谓米字型搜索的，试图达成“保证输出的东西靠谱”之目的

d_step = 0.035 ;
[qianyuan,qianyuan_d,qianyuan_d2] = buquan_Bspline4_2seg_withd(x1 , y1 , x2 , y2,...
    dy1dx ,d2y1dx2,d3y1dx3,dy2dx,d2y2dx2 ,d3y2dx3,xzhong,yzhong)  ;
panju_2 = panju2(uv_top_r,uv_bot_r,qianyuan,qianyuan_d,qianyuan_d2);
fprintf('\nMXairfoil: 以默认的高阶导数求导时，判据2取值是%f \n',panju_2) ; 

N = 100;%给定一个最大的限额。
n = 1 ; 

d3ydx3_8gua = zeros(8,2) ;
panju2_8gua = zeros(8,1) ;

while(panju_2>10)
    fprintf('MXairfoil: 现在往外扩张，当前第%d步,判据2取值是%f\n',n,panju_2);
    %书之以先天八卦之形
%     d3ydx3_8gua = zeros(8,2) ;
%     panju2_8gua = zeros(8,1) ;
    %乾
%     d3y1dx3_111 = d3y1dx3 + 0 ;
    d3ydx3_8gua(1,1) = d3y1dx3 + 0 ;
    d3ydx3_8gua(1,2) = d3y2dx3  + d_step*n ; 
    
    %巽
    d3ydx3_8gua(2,1) = d3y1dx3 + d_step/sqrt(2)*n ; 
    d3ydx3_8gua(2,2) = d3y2dx3 + d_step/sqrt(2)*n ; 
    
    %坎
    d3ydx3_8gua(3,1) = d3y1dx3 + d_step*n ; 
    d3ydx3_8gua(3,2) = d3y2dx3 + 0 ; 
    
    %艮
    d3ydx3_8gua(4,1) = d3y1dx3 + d_step/sqrt(2)*n ; 
    d3ydx3_8gua(4,2) = d3y2dx3 - d_step/sqrt(2)*n ;     
    
    %坤
    d3ydx3_8gua(5,1) = d3y1dx3  ; 
    d3ydx3_8gua(5,2) = d3y2dx3 - d_step*n ;     
    
    %震
    d3ydx3_8gua(6,1) = d3y1dx3 - d_step/sqrt(2)*n ; 
    d3ydx3_8gua(6,2) = d3y2dx3 - d_step/sqrt(2)*n ;        
    
    %离
    d3ydx3_8gua(7,1) = d3y1dx3 - d_step*n ;     
    d3ydx3_8gua(7,2) = d3y2dx3 ;
    
    %兑
    d3ydx3_8gua(8,1) = d3y1dx3 - d_step/sqrt(2)*n ; 
    d3ydx3_8gua(8,2) = d3y2dx3 + d_step/sqrt(2)*n ;  
    
    %计算各个方位的判据2的值
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
    
    %计算总的判据2的值；
%     panju_2 = min(panju2_8gua) ; 
%     huatu2([d3ydx3_8gua;d3ydx3_8gua(1,:)]) ; 
    panju2_paixu = sort(panju2_8gua) ; 
    panju_2 = panju2_paixu(2) ; %防一手过拟合。用第二小的。
%     huatu2(qianyuan) ; 

    %更新一下这些变量，搞成比较梯度下降法的那种。
    weizhi = find(panju2_8gua==panju_2) ; 
    d3y1dx3 = d3ydx3_8gua(weizhi(1),1);
    d3y2dx3 = d3ydx3_8gua(weizhi(1),2);
    
    n=n+1 ; 
    if(n>N)
        panju_2=0;
        fprintf('MXairfoil: 求解样条叶尖的时候步数超了 \n');
    end
end

%找出使得循环退出的正确结果。笨笨地重新算一遍。
i = find(panju2_8gua==panju_2) ; 
if(panju_2==0)%说明是异常退出。不用这个的话i就是空了就离谱了。
    i=find(panju2_8gua==min(panju2_8gua)) ; 
end

% 即使有了前面那个，也还是会有空i，特别是用不同的策略的时候。在这里好好地安排一下。
[hang_i,lie_i] = size(i) ; 
if(hang_i*lie_i ==0)
    [hang , ~] = size(d3ydx3_8gua)  ;
    i = hang /2 ;
end
[qianyuan,qianyuan_d,qianyuan_d2] = buquan_Bspline4_2seg_withd(x1 , y1 , x2 , y2,...
    dy1dx ,d2y1dx2,d3ydx3_8gua(i,1),dy2dx,d2y2dx2 ,d3ydx3_8gua(i,2),xzhong,yzhong)  ;

Pcp = Pcp_Bspline4_2seg_withd(x1 , y1 , x2 , y2,...
     dy1dx ,d2y1dx2,d3ydx3_8gua(i,1),dy2dx,d2y2dx2 ,d3ydx3_8gua(i,2),xzhong,yzhong)  ;
%尝试把它平移到远离原点的地方来算,以避免接近零带来的种种问题。
 Pcp = Pcp + 2 ; 
 t=0:0.01:1 ; 
 qianyuan_jia = yangtiao4(Pcp,t) ;
 qianyuan_jia_d = yangtiao4_d(Pcp,t) ;
 qianyuan_jia_d2 = yangtiao4_d2(Pcp,t) ;
 panju2_jia = panju2(uv_top_r+2,uv_bot_r+2,qianyuan_jia,qianyuan_jia_d,qianyuan_jia_d2);
 fprintf('\nMXairfoil: 判据2计算出来的结果为 %f \n',panju2_jia) ;
 
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