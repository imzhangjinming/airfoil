function zhi = get_houdum(wenjianming)
% 这个是重新写一个专门来弄生成v_m的（读取进来之后是P_m）。不然生成的部分和主程序岔在一起简直日了狗了。
% 其本体是fuke_yixing2
wenjianming ='..\input\CDA1' ; 
[chi_in,chi_out,xi,vpp,vp,bili,...
lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi,...
p_houdu,p_camber,p_m] = dataInput2(wenjianming);

k=1 ; %因为是直接反求回去的所以k就等于1就行了嘛

fendu =1 ; 
lethk = lethk*fendu/bili ; 
tethk = tethk*fendu/bili ; 
mxthk = mxthk*fendu/bili ;
umxthk = umxthk/bili ; 

houdu_m = [0,0,0,0,0,0,0,0] ; 
houdu = get_thickness3gai(beta_in1,beta_out1,xi,lethk,tethk,umxthk,mxthk,houdu_m);
houdu_cankao(1:2,:) = [] ; 
houdu_cankao(end-1:end,:) = [] ; 
% huatu2(houdu_cankao);huatu2(houdu);

% 先处理前面一半
index = find(houdu_cankao(:,1)<umxthk) ; 
houdu_cankao_qian = houdu_cankao(index,:) ; 
houdu_cankao_hou = houdu_cankao(index(end):end,:) ; 

index = find(houdu(:,1)<umxthk) ; 
houdu_qian = houdu(index,:) ; 
houdu_hou = houdu(index(end):end,:);

bianliang_qian  = subtract_2disparate(houdu_cankao_qian,houdu_qian);
bianliang_hou = subtract_2disparate(houdu_cankao_hou,houdu_hou);
bianliang = [bianliang_qian ; bianliang_hou] ; 

% huatu2(houdu_cankao_qian) ; huatu2(houdu_qian) ; huatu2(bianliang_qian) ; 
% huatu2(houdu_cankao_hou) ; huatu2(houdu_hou) ; huatu2(bianliang_hou) ;
% 这里需要搞一个用于“两个序列构成的数列求出它们的差的序列”这样的东西。

% shuchu2 里面搬过来的代码，为了这头能验证能调。
%这个是直接处理成多项式的了。然后把用于对比的东西也输出出去可也。
s = 'houdu_m';
file = [wenjianming '\' s '.txt'] ; 
file_cankao = [wenjianming '\' s '.dat'] ; 

p_qian = polyfit(bianliang_qian(:,1),bianliang_qian(:,2),3) ;
p_hou = polyfit(bianliang_hou(:,1),bianliang_hou(:,2),3) ;
p_bianliang = [p_qian,p_hou];
% 三阶多项式，差不多了。其实二次已经不错了。毕竟是分了两段的。
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


houdu_m = get_thickness3gai(beta_in1,beta_out1,xi,lethk,tethk,umxthk,mxthk,p_bianliang);


huatu2(houdu_cankao); huatu2(houdu_m);

end