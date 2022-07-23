function zhi = fuke_yixing(N)
%����������������͵ġ����������������̺õ����͡�
% N =1 ; 
[chi_in,chi_out,xi,vpp,vp,bili...
    lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
    beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi] = get_yixing2(N) ; 
k=1 ; %��Ϊ��ֱ�ӷ����ȥ������k�͵���1��������
% yixing_uv = [yixing_all{N,1}(:,3),yixing_all{N,1}(:,1)] ; 
yixing_all = get_yixing(N) ; 
yixing_uv = [yixing_all(:,3),yixing_all(:,1)] ; 
yixing_uv = xuanzhuan(yixing_uv,-xi) ; 
yixing_uv = yixing_uv ./bili ; %�����Ҫ�������Ƚϵġ�
houdu_cankao = houdu_cankao./bili ; %���Ҳ����Ҫ�����Ƚϵġ�


%�ã�Ȼ���Ҫ��ʼ�Լ������ˡ�
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
% uv_all = chachong(uv_all) ; %����ǰ������ص��ĵ�ȥ�����Է���һ��
uv_all = chachong2(uv_all) ;
uv_all(:,2) = uv_all(:,2) + H_pingyi ; 
uv_all(:,1) = uv_all(:,1) + L_pingyi ; 
%���ˣ���ά���͵ĸ�������������˵ġ�(�����ٵ�)

%Ȼ����ת������Ū��ȥ��
uv_all = xuanzhuan(uv_all,xi) ; 
uv_all = uv_all.*bili ; 
zhi = uv_all ; 


%������������Ѿ���ɸ��̼����ˡ�Ȼ�����濼�ǵ���Ūһ�����blockMeshDict
if(N==13)
%     uv_all = xuanzhuan(uv_all , -xi ) ;  
%     uv_all(:,2) = uv_all(:,2) - H_pingyi*bili ; 
%     uv_all(:,1) = uv_all(:,1) - L_pingyi*bili ; 
%     uv_all(:,2) = uv_all(:,2) - uv_all(1,2)  ; 
%     uv_all(:,1) = uv_all(:,1) - uv_all(1,1) ; 
    get_blockMeshDict(uv_all , chi_in+xi , chi_out+xi , bili) ; 
end 

end 