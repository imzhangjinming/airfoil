function [zhi,chi_in,chi_out,k,xi,v,vp,vpp2,...
    lecurv,tecurv,lethk,tethk,umxthk,mxthk] = get_initial(wenjianming)
%从头开始改，好好地搞搞输入输出，不要用之前的那个shishi1了。
% wenjianming = '../input/test/' ; 
%尝试弄一弄翼型生成和块生成的东西。

% figure(1) ; 
% hold on ; 
% plot(blade.mpie , blade.theta) ; 
% axis('equal') ; 
% plot(controlPoint.u , controlPoint.v) ; 
load([wenjianming 'controlPoint.mat'])
kongzhidian=zeros(size(controlPoint)) ; 
kongzhidian(:,1) = controlPoint.u ; 
kongzhidian(:,2) = controlPoint.v ; 
kongzhidian = [0 0 ; kongzhidian ; 1 0];
% 四次样条要五个点，信然之矣。
% plot(kongzhidian(:,1) , kongzhidian(:,2)) ; 
global beta_in beta_out ; 
% beta_in =  -62.17615474  /180*pi; %为了能够直接进行三角运算，搞成这种形式 
% beta_out = 12.82488290 /180*pi; 
beta_in = 30 /180*pi;
beta_out  = -60 /180*pi ; 

t = 0:0.1:1 ; 
% shishi = [-0.04 -7 ; 0 0 ; 0.04  7 ; 0.2 3.5 ;0.5 1.5 ; 0.8 0.8 ; 1.0 0 ; 1.2 -0.8 ] ; 
% load('../input/test/camberLinePoint.mat');

load([wenjianming 'camberLinePoint.mat']);
global vpp ; 
vpp = yangtiao(shishi,t) ;  %文献复现成功，说明至少样条这部分没什么问题。
vp = jifen(vpp) ; 
% plot(vp(:,1),vp(:,2)./-1 + 1.5) ; %这个是要修正了k的
vp(:,2) = vp(:,2)./-1 + 1.5 ; 
v = jifen(vp) ; 
% plot(v(:,1),v(:,2)) ; 


% vpp = yangtiao(kongzhidian,t) ; 
% vp = jifen(vpp) ; 


% 准备开始迭代求解了。
chi_in = 1 ; 
chi_out = -0.54 ; 
k = -1 ; 
xi = 0 ; 

fun = @fangchengzu;
x0 = [chi_in,chi_out , k ,xi ];
x = fsolve(fun,x0) ; 
chi_in = x(1) ; 
chi_out = x(2) ; 
k = x(3) ; 
xi = x(4) ; 

% get parameters for something like thickness
load('../input/test/thickness.mat');
% return some value.
zhi = 0 ; 
vpp2 = vpp ; 
%  lecurv,tecurv,lethk,tethk,umxthk,mxthk

end 

function F = fangchengzu(x)
global vpp beta_in beta_out 
vp = jifen(vpp) ; 
vp(:,2) = vp(:,2).*x(3) + tan(x(1)) ; 
v = jifen(vp) ; 
[hang lie] = size(v) ; 

F(1) = x(1) + x(4) - beta_in ; 
F(2) = x(2) + x(4) - beta_out ; 
F(3) = vp(hang , 2) - tan(x(2)) ; 
F(4) = v(hang ,2) ; 
end 