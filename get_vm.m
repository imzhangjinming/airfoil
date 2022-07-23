function zhi = get_vm(wenjianming)
% 这个是重新写一个专门来弄生成v_m的（读取进来之后是P_m）。不然生成的部分和主程序岔在一起简直日了狗了。
% 其本体是fuke_yixing2
wenjianming ='..\input\CDA1' ; 
[chi_in,chi_out,xi,vpp,vp,bili,...
lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi,...
p_houdu,p_camber,p_m] = dataInput2(wenjianming);

k=1 ; %因为是直接反求回去的所以k就等于1就行了嘛

%参考翼型还是读进来显得专业一点。
yixing_cankao_top = load([wenjianming '\yixing_top.dat']) ;
yixing_cankao_bot = load([wenjianming '\yixing_bot.dat']) ;
camber_cankao = load([wenjianming '\uv_camber.dat']) ;
yixing_cankao_top = yixing_cankao_top/bili ; 
yixing_cankao_bot = yixing_cankao_bot/bili ;

v = camber_cankao ; 
[v2,C] = get_zhonghuxian(chi_in,chi_out,k,xi,vpp);
% bianliang = [v(:,1) v2(:,2)-v(:,2)]
bianliang  = subtract_2disparate(v,v2);
% 这里需要搞一个用于“两个序列构成的数列求出它们的差的序列”这样的东西。
% 
% huatu2(camber_cankao) ; huatu2(v2); huatu2(v_m);

% shuchu2 里面搬过来的代码，为了这头能验证能调。
%这个是直接处理成多项式的了。然后把用于对比的东西也输出出去可也。
s = 'v_m';
file = [wenjianming '\' s '.txt'] ; 
file_cankao = [wenjianming '\' s '.dat'] ; 

p_bianliang = polyfit(bianliang(:,1),bianliang(:,2),4) ;
% 三阶多项式，差不多了。要四阶其实也不是不行嗷
% 四阶的能好不少，那用四阶的吧。get_zhonghuxian_m里面也得相应的改。
[hang,lie] = size(p_bianliang) ; 
wenjian = fopen(file,'w');
for i=1:lie
    fprintf(wenjian, '%f    ' ,p_bianliang(1,i));
end 
zhi = fclose(wenjian);

[hang,lie] = size(bianliang) ; 
wenjian2 = fopen(file_cankao,'w');
for i=1:hang 
    fprintf(wenjian2, '%f    %f    \n' ,bianliang(i,1),bianliang(i,2));
end 
zhi = zhi + fclose(wenjian2);


[v3,C2] = get_zhonghuxian_m(chi_in,chi_out,k,xi,vpp,p_bianliang);


% huatu2(camber_cankao) ; huatu2(v2); huatu2(v_m);
huatu2(camber_cankao); huatu2(v3);

end