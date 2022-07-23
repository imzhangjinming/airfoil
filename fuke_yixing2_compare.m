function [zhi , index ] = fuke_yixing2_compare(wenjianming,state)
% �����ڸ߿����Ե��Զ�����άҶ�����ɵĶ�������������һ����Ҫ����������� 
% N =1 ; 
% [chi_in,chi_out,xi,vpp,vp,bili...
%     lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
%     beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi] = get_yixing_fuke(wenjianming) ; 

%���Ը��������������֡�
% �������������NASA Rotor 67�ġ�
% [chi_in,chi_out,xi,vpp,vp,bili,...
% lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
% beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi] = dataInput1(wenjianming) ;

%������CDA������������һ��
[chi_in,chi_out,xi,vpp,vp,bili,...
lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi,...
p_houdu,p_camber,p_m,houdu_m] = dataInput2(wenjianming);

% ����ġ�����ĸı䣬�������������ˡ�
chi_in = state(1) ; 
chi_out = state(2) ; 
mxthk = state(3) ; 
umxthk = state(4) ; 


k=1 ; %��Ϊ��ֱ�ӷ����ȥ������k�͵���1��������

%�ο����ͻ��Ƕ������Ե�רҵһ�㡣
yixing_cankao_top = load([wenjianming '\yixing_top.dat']) ;
yixing_cankao_bot = load([wenjianming '\yixing_bot.dat']) ;
camber_cankao = load([wenjianming '\uv_camber.dat']) ;
yixing_cankao_top = yixing_cankao_top/bili ; 
yixing_cankao_bot = yixing_cankao_bot/bili ;
% huatu2(yixing_cankao_top);
% huatu2(yixing_cankao_bot);
% huatu2(camber_cankao) ;
%�ã�Ȼ���Ҫ��ʼ�Լ������ˡ�
% [v2,C2] = get_zhonghuxian(chi_in,chi_out,k,xi,vpp);
[v,C2] = get_zhonghuxian_m(chi_in,chi_out,k,xi,vpp,p_m);
% [v,C] = get_zhonghuxian_toulan(chi_in,chi_out,k,xi,vpp,p_camber);

% huatu2(camber_cankao) ;huatu2(v) ; huatu2(v2);
% bianliang = [v(:,1) v2(:,2)-v(:,2)];file ='v_m.txt';
% ��һ�����������shuchu2��ȡ�������ġ�
% 2021��3��21��20:51:18������������⡣���������ס�
% 2021��3��22��19:41:13��͵��֮��������ǹ�ȥ�ˣ������ȿ�����ô�����������ա�
% 2021��3��31��14:11:30������������֮�󣬹���������˵��ȥ�ˣ�����chi_in����Ҳ���е�仯��
fendu =1 ; 
lethk = lethk*fendu/bili ; 
tethk = tethk*fendu/bili ; 
mxthk = mxthk*fendu/bili ;
umxthk = umxthk/bili ; 

houdu = get_thickness3gai(beta_in1,beta_out1,xi,...
    lethk,tethk,umxthk,mxthk,houdu_m);
% houdu = get_thickness_toulan(p_houdu) ;%���������ϵĻ�ͦ�õġ�2021��3��21��20:18:52
% huatu2(houdu_cankao);huatu2(houdu2); 
[uv_top,uv_bot] = get_airfoil(v,vp,houdu,lethk,tethk);
% [uv_top,uv_bot] = get_airfoil(camber_cankao,weifen_uv(camber_cankao),houdu,lethk,tethk);
% huatu2(yixing_cankao_top);huatu2(uv_top)
% huatu2(yixing_cankao_bot);huatu2(uv_bot)


P1 = uv_top(end,1:2) ; 
P2 = uv_bot(end,1:2) ; 
i=1 ; 
while((norm(P1-P2,2)<0.001)&&(i<10))
    %��һ���ݴ���ƣ���Ȼ�����㿿��̫���˾�ֱ��ը�ˡ�
    uv_top(end,:)=[] ; 
    uv_bot(end,:)=[] ; 
    P1 = uv_top(end,1:2) ; 
    P2 = uv_bot(end,1:2) ; 
     i=i+1 ; 
end
i=1 ; 
P3 = uv_top(1,1:2) ; 
P4 = uv_bot(1,1:2) ; 
while((norm(P3-P4,2)<0.001)&&(i<10))
    %��һ���ݴ���ƣ���Ȼ�����㿿��̫���˾�ֱ��ը�ˡ�
    uv_top(1,:)=[] ; 
    uv_bot(1,:)=[] ; 
    P3 = uv_top(1,1:2) ; 
    P4 = uv_bot(1,1:2) ; 
     i=i+1 ; 
end


[uv_top3,uv_bot3] = get_qianhouyuan(uv_top,uv_bot,lethk ,tethk,chi_in,chi_out);

% huatu2(uv_top);huatu2(uv_bot);
% huatu2(uv_top3);huatu2(uv_bot3);


uv_all = [uv_top3;flipud(uv_bot3)] ; 
[index ,~] = size(uv_top3);
% uv_all = chachong(uv_all) ; %����ǰ������ص��ĵ�ȥ�����Է���һ��
uv_all = chachong2(uv_all) ;
% uv_all(:,2) = uv_all(:,2) + H_pingyi ; 
% uv_all(:,1) = uv_all(:,1) + L_pingyi ; 
%���ˣ���ά���͵ĸ�������������˵ġ�(�����ٵ�)

%Ȼ����ת������Ū��ȥ��
uv_all = xuanzhuan(uv_all,xi) ; 
uv_all = uv_all.*bili ; 
zhi = uv_all ; 
% huatu2(yixing_cankao_top);
% huatu2(yixing_cankao_bot);
% huatu2(uv_all);
% %2021��3��22��20:07:59��һ·͵���Ļ�������������Ѿ����ǰ����͸��̳����ˡ�

%������������Ѿ���ɸ��̼����ˡ�Ȼ�����濼�ǵ���Ūһ�����blockMeshDict
if(0)
%     uv_all = xuanzhuan(uv_all , -xi ) ;  
%     uv_all(:,2) = uv_all(:,2) - H_pingyi*bili ; 
%     uv_all(:,1) = uv_all(:,1) - L_pingyi*bili ; 
%     uv_all(:,2) = uv_all(:,2) - uv_all(1,2)  ; 
%     uv_all(:,1) = uv_all(:,1) - uv_all(1,1) ; 
    get_blockMeshDict(uv_all , chi_in+xi , chi_out+xi , bili) ; 
end 

end 