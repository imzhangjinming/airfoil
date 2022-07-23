function [zhi , index ] = fuke_yixing2_compare(wenjianming,state)
% 服务于高可用性的自动化二维叶形生成的东西，用来整理一下需要的输入输出。 
% N =1 ; 
% [chi_in,chi_out,xi,vpp,vp,bili...
%     lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
%     beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi] = get_yixing_fuke(wenjianming) ; 

%尝试搞成输入输出的那种。
% 这个是用来复刻NASA Rotor 67的。
% [chi_in,chi_out,xi,vpp,vp,bili,...
% lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
% beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi] = dataInput1(wenjianming) ;

%用来搞CDA算例的重新整一个
[chi_in,chi_out,xi,vpp,vp,bili,...
lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi,...
p_houdu,p_camber,p_m,houdu_m] = dataInput2(wenjianming);

% 额外的、输入的改变，就体现在这里了。
chi_in = state(1) ; 
chi_out = state(2) ; 
mxthk = state(3) ; 
umxthk = state(4) ; 


k=1 ; %因为是直接反求回去的所以k就等于1就行了嘛

%参考翼型还是读进来显得专业一点。
yixing_cankao_top = load([wenjianming '\yixing_top.dat']) ;
yixing_cankao_bot = load([wenjianming '\yixing_bot.dat']) ;
camber_cankao = load([wenjianming '\uv_camber.dat']) ;
yixing_cankao_top = yixing_cankao_top/bili ; 
yixing_cankao_bot = yixing_cankao_bot/bili ;
% huatu2(yixing_cankao_top);
% huatu2(yixing_cankao_bot);
% huatu2(camber_cankao) ;
%好，然后就要开始自己生成了。
% [v2,C2] = get_zhonghuxian(chi_in,chi_out,k,xi,vpp);
[v,C2] = get_zhonghuxian_m(chi_in,chi_out,k,xi,vpp,p_m);
% [v,C] = get_zhonghuxian_toulan(chi_in,chi_out,k,xi,vpp,p_camber);

% huatu2(camber_cankao) ;huatu2(v) ; huatu2(v2);
% bianliang = [v(:,1) v2(:,2)-v(:,2)];file ='v_m.txt';
% 这一行是用来配合shuchu2获取修正量的。
% 2021年3月21日20:51:18，这个还有问题。就尼玛离谱。
% 2021年3月22日19:41:13，偷懒之后姑且算是过去了，现在先考虑怎么把它连起来罢。
% 2021年3月31日14:11:30，安排了修正之后，姑且算是能说过去了，改了chi_in起码也能有点变化。
fendu =1 ; 
lethk = lethk*fendu/bili ; 
tethk = tethk*fendu/bili ; 
mxthk = mxthk*fendu/bili ;
umxthk = umxthk/bili ; 

houdu = get_thickness3gai(beta_in1,beta_out1,xi,...
    lethk,tethk,umxthk,mxthk,houdu_m);
% houdu = get_thickness_toulan(p_houdu) ;%这两个符合的还挺好的。2021年3月21日20:18:52
% huatu2(houdu_cankao);huatu2(houdu2); 
[uv_top,uv_bot] = get_airfoil(v,vp,houdu,lethk,tethk);
% [uv_top,uv_bot] = get_airfoil(camber_cankao,weifen_uv(camber_cankao),houdu,lethk,tethk);
% huatu2(yixing_cankao_top);huatu2(uv_top)
% huatu2(yixing_cankao_bot);huatu2(uv_bot)


P1 = uv_top(end,1:2) ; 
P2 = uv_bot(end,1:2) ; 
i=1 ; 
while((norm(P1-P2,2)<0.001)&&(i<10))
    %搞一点容错机制，不然两个点靠的太近了就直接炸了。
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
    %搞一点容错机制，不然两个点靠的太近了就直接炸了。
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
% uv_all = chachong(uv_all) ; %这个是把里面重叠的点去掉，以防万一。
uv_all = chachong2(uv_all) ;
% uv_all(:,2) = uv_all(:,2) + H_pingyi ; 
% uv_all(:,1) = uv_all(:,1) + L_pingyi ; 
%至此，二维翼型的复刻生成是完成了的。(无量纲的)

%然后旋转和缩放弄回去。
uv_all = xuanzhuan(uv_all,xi) ; 
uv_all = uv_all.*bili ; 
zhi = uv_all ; 
% huatu2(yixing_cankao_top);
% huatu2(yixing_cankao_bot);
% huatu2(uv_all);
% %2021年3月22日20:07:59，一路偷懒的话，到这里姑且已经算是把翼型复刻出来了。

%本来到上面就已经完成复刻几何了。然后下面考虑的是弄一手输出blockMeshDict
if(0)
%     uv_all = xuanzhuan(uv_all , -xi ) ;  
%     uv_all(:,2) = uv_all(:,2) - H_pingyi*bili ; 
%     uv_all(:,1) = uv_all(:,1) - L_pingyi*bili ; 
%     uv_all(:,2) = uv_all(:,2) - uv_all(1,2)  ; 
%     uv_all(:,1) = uv_all(:,1) - uv_all(1,1) ; 
    get_blockMeshDict(uv_all , chi_in+xi , chi_out+xi , bili) ; 
end 

end 