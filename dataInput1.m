function [chi_in,chi_out,xi,vpp,vp,bili,...
    lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
    beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi] = dataInput1(wenjianming)
%2021年2月17日16:25:19新的尝试改装。比想象中的还要简易一些。讲道理稍微复杂点的情况这个估计就应付不了了。

chi_in = load([wenjianming '\chi_in.txt']) ; 
chi_out = load([wenjianming '\chi_out.txt']) ; 
xi = load([wenjianming '\xi.txt']) ; 
% vpp = load([wenjianming '\vpp\vpp.txt']) ; 
% vpp2 = get_vpp2([wenjianming '\vpp\vpp_parameter.txt']);
vpp = get_vpp2([wenjianming '\vpp\vpp_parameter.txt']);
% huatu2(vpp);
% huatu2(vpp2);
% vp2 = jifen(vpp)+0.16 ; 
% vp = load([wenjianming '\vpp\vp.txt']) ; 
vp = jifen(vpp)+0.16 ; 
% huatu2(vp);
% huatu2(vp2);
bili = load([wenjianming '\bili.txt']) ; 
lecurv = load([wenjianming '\lecurv.txt']) ; 
tecurv = load([wenjianming '\tecurv.txt']) ; 
lethk = load([wenjianming '\lethk.txt']) ;
tethk = load([wenjianming '\tethk.txt']) ;
umxthk = load([wenjianming '\umxthk.txt']) ;
mxthk = load([wenjianming '\mxthk.txt']) ;
beta_in1 = load([wenjianming '\beta_in.txt']) ;
beta_out1 = load([wenjianming '\beta_out.txt']) ;
H_pingyi = load([wenjianming '\H_pingyi.txt']) ;
L_pingyi = load([wenjianming '\L_pingyi.txt']) ;
houdu_cankao = 0 ; %这就是个防止出错的占位符。
end 