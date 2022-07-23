function zhi = fuke_yixing(N)
%这个是用来复刻翼型的。输入层数，输出复刻好的翼型。
% N =1 ; 
[chi_in,chi_out,xi,vpp,vp,bili...
    lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
    beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi] = get_yixing2(N) ; 
k=1 ; %因为是直接反求回去的所以k就等于1就行了嘛
% yixing_uv = [yixing_all{N,1}(:,3),yixing_all{N,1}(:,1)] ; 
yixing_all = get_yixing(N) ; 
yixing_uv = [yixing_all(:,3),yixing_all(:,1)] ; 
yixing_uv = xuanzhuan(yixing_uv,-xi) ; 
yixing_uv = yixing_uv ./bili ; %这个主要是拿来比较的。
houdu_cankao = houdu_cankao./bili ; %这个也是主要拿来比较的。


%好，然后就要开始自己生成了。
[v,C] = get_zhonghuxian(chi_in,chi_out,k,xi,vpp);

fendu =1 ; 
lethk = lethk*fendu/bili ; 
tethk = tethk*fendu/bili ; 
mxthk = mxthk*fendu/bili ;
umxthk = umxthk/bili ; 

% houdu = get_thickness(lecurv,tecurv,lethk,tethk,umxthk,mxthk);
% houdu = get_thickness2(beta_in1,beta_out1,xi,lethk,tethk,umxthk,mxthk) ; 
% houdu = get_thickness4(beta_in1,beta_out1,xi,lecurv,tecurv,lethk,tethk,umxthk,mxthk);
% houdu = get_thickness5(beta_in1,beta_out1,xi,lecurv,tecurv,lethk,tethk,umxthk,mxthk);
houdu = get_thickness3gai(beta_in1,beta_out1,xi,lethk,tethk,umxthk,mxthk);

[uv_top,uv_bot] = get_airfoil(v,vp,houdu,lethk,tethk);

[uv_top3,uv_bot3] = get_qianhouyuan(uv_top,uv_bot,lethk ,tethk,chi_in,chi_out);

uv_all = [uv_top3;flipud(uv_bot3)] ; 
% uv_all = chachong(uv_all) ; %这个是把里面重叠的点去掉，以防万一。
uv_all = chachong2(uv_all) ;
uv_all(:,2) = uv_all(:,2) + H_pingyi ; 
uv_all(:,1) = uv_all(:,1) + L_pingyi ; 
%至此，二维翼型的复刻生成是完成了的。(无量纲的)

%然后旋转和缩放弄回去。
uv_all = xuanzhuan(uv_all,xi) ; 
uv_all = uv_all.*bili ; 
zhi = uv_all ; 


%本来到上面就已经完成复刻几何了。然后下面考虑的是弄一手输出blockMeshDict
if(N==13)
%     uv_all = xuanzhuan(uv_all , -xi ) ;  
%     uv_all(:,2) = uv_all(:,2) - H_pingyi*bili ; 
%     uv_all(:,1) = uv_all(:,1) - L_pingyi*bili ; 
%     uv_all(:,2) = uv_all(:,2) - uv_all(1,2)  ; 
%     uv_all(:,1) = uv_all(:,1) - uv_all(1,1) ; 
    get_blockMeshDict(uv_all , chi_in+xi , chi_out+xi , bili) ; 
end 

end 