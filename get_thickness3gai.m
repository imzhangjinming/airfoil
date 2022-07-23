function zhi = get_thickness3gai(beta_in1,beta_out1,xi0,...
    lethk0,tethk0,umxthk0,mxthk0,houdu_m)
%wdnmd样条曲线去死吧，直接整个多项式的垃圾倒。
%安排一个弄厚度分布的，讲道理和前面的那些应该是无关的。
global beta_in11 beta_out11 xi lethk tethk umxthk mxthk
xi = xi0 ; 
beta_in11 = beta_in1-xi ; 
beta_out11 = beta_out1-xi ; 


lethk = lethk0 ; 
tethk = tethk0 ; 
umxthk = umxthk0 ; 
mxthk = mxthk0 ; 

%总体上来说是u做u的，v做v的来求解的
f1houdu = @(xx,xishu) xishu(1)*xx.^2 + xishu(2)*xx+xishu(3) ; 
f2houdu = @(xx,xishu) xishu(4)*xx.^2 + xishu(5)*xx+xishu(6) ; 
f1phoudu = @(xx,xishu) 2*xishu(1)*xx + xishu(2); 
f2phoudu = @(xx,xishu) 2*xishu(4)*xx + xishu(5);  

fun = @fangchengzu31;
% t1 = lethk0:0.01:umxthk ;
% t2 = umxthk:0.01:(1-tethk0) ; %这个是决定点数的。

t1 = 0:0.05:umxthk ;
t2 = umxthk:0.05:1 ; 
x0 = [-1,0 , mxthk ,-1,0 , mxthk  ];
x = fsolve(fun,x0) ; 

houdu = [t1',f1houdu(t1',x) ; t2',f2houdu(t2',x)];
% zhi = houdu ; 

index = find(houdu(:,1)<umxthk) ; 
houdu_qian = houdu(index,:) ; 
houdu_hou = houdu(index(end)+1:end,:);
%2021年7月26日15:22:59没什么好的辙，反正别问问就是加修正。
[hang,lie] = size(houdu_m) ; 
p_qian = houdu_m(1:lie/2) ; 
p_hou = houdu_m(lie/2+1:end) ; 
houdu_m_qian = polyval(p_qian,houdu_qian(:,1)) ; 
houdu_m_hou = polyval(p_hou,houdu_hou(:,1)) ;

houdu_qian(:,2) = houdu_qian(:,2) - houdu_m_qian ; 
houdu_hou(:,2) = houdu_hou(:,2) - houdu_m_hou ; 
houdu_xiuzheng = [houdu_qian ; houdu_hou] ; 

zhi = houdu_xiuzheng ;

function F = fangchengzu31(x)
    %就最傻逼的多项式方程组就完了。
% global beta_in11 beta_out11 xi lethk tethk umxthk mxthk
f1houdu = @(xx,xishu) xishu(1)*xx.^2 + xishu(2)*xx+xishu(3) ; 
f2houdu = @(xx,xishu) xishu(4)*xx.^2 + xishu(5)*xx+xishu(6) ; 
f1phoudu = @(xx,xishu) 2*xishu(1)*xx + xishu(2); 
f2phoudu = @(xx,xishu) 2*xishu(4)*xx + xishu(5);  
C = 1 ; 
% F(1) = atan(f1phoudu(0+C*lethk,x))-(beta_in11-xi) ; 
% F(2) = atan(f2phoudu(1-C*tethk,x)) - (beta_out11-xi) ; 
F(1) = f1houdu(umxthk,x)-mxthk ; 
F(2) = f2houdu(umxthk,x)-mxthk ; 
F(3) = f1phoudu(umxthk,x)-0 ; 
F(4) = f2phoudu(umxthk,x)-0 ; 
F(5) = f1houdu(0+C*lethk/2,x)- lethk/2 ; 
F(6) = f2houdu(1-C*tethk/2,x)- tethk/2 ; 
end 

end 