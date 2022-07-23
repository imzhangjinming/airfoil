function [zhi,zhi_d,zhi_d2] = buquan_Bspline4_2seg_withd(x1 , y1 , x2 , y2,...
    dy1dx ,d2y1dx2,d3y1dx3,dy2dx,d2y2dx2 ,d3y2dx3,xzhong,yzhong)
%�����һ����������ǰ��˵��һ��������ܲ�ȫ��һ�Σ����أ����ߵĶ������Ա����á�
a1 = 1/24 ; 
a2 = 11/24 ; 
yichuan = [a1 a2 a2 a1] ; 
yichuanp = [-1/6 -1/2 1/2 1/6] ; 
yichuanpp = [1/2 -1/2 -1/2 1/2] ;
yichuanppp = [-1 3 -3 1] ; 
yichuanpppp = [1 -4 6 -4 1];

A=  [yichuan 0 0 zeros(1,6)            ;...
     zeros(1,6) yichuan 0 0          ;...
     -1*dy1dx.*[yichuanp 0 0] yichuanp 0 0 ;...
     -1*d2y1dx2.*[yichuanpp 0 0] yichuanpp 0 0 ;...
     -1*d3y1dx3.*[yichuanppp 0 0] yichuanppp 0 0  ;...
     
     0 0 yichuan zeros(1,6)            ;...
     zeros(1,6) 0 0 yichuan            ;...
     -1*dy2dx.*[0 0 yichuanp] 0 0 yichuanp ;...
     -1*d2y2dx2.*[0 0 yichuanpp] 0 0 yichuanpp ;...
     -1*d3y2dx3.*[0 0 yichuanppp] 0 0 yichuanppp  ;...    
     
     0 yichuan 0 zeros(1,6) ;...
     zeros(1,6) 0 yichuan 0 
     ];
 
 
 b = [x1 y1 0 0 0 , x2 y2 0 0 0 , xzhong ,yzhong]' ;
 
  zhi = rank(A) ; 
 fprintf('����A���ȣ� %d \n',zhi);
 
  jie = mldivide(A,b) ; 
 Pcp(:,1) = jie(1:6) ;
 Pcp(:,2) = jie(7:12) ;
 
 t=0:0.01:1 ; 
 zhi = yangtiao4(Pcp,t) ;
 
 fprintf('�ɹ����������ߡ��ӵ�(%f,%f)����(%f,%f)��\n�����˵�(%f,%f), En Taro XXH !\n',x1,y1,x2,y2,xzhong,yzhong);

 zhi_d = yangtiao4_d(Pcp,t) ;
 zhi_d2 = yangtiao4_d2(Pcp,t) ;
 
%  zhi = 0 ; 
end