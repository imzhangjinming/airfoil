function zhi = get_vm(wenjianming)
% ���������дһ��ר����Ū����v_m�ģ���ȡ����֮����P_m������Ȼ���ɵĲ��ֺ����������һ���ֱ���˹��ˡ�
% �䱾����fuke_yixing2
wenjianming ='..\input\CDA1' ; 
[chi_in,chi_out,xi,vpp,vp,bili,...
lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi,...
p_houdu,p_camber,p_m] = dataInput2(wenjianming);

k=1 ; %��Ϊ��ֱ�ӷ����ȥ������k�͵���1��������

%�ο����ͻ��Ƕ������Ե�רҵһ�㡣
yixing_cankao_top = load([wenjianming '\yixing_top.dat']) ;
yixing_cankao_bot = load([wenjianming '\yixing_bot.dat']) ;
camber_cankao = load([wenjianming '\uv_camber.dat']) ;
yixing_cankao_top = yixing_cankao_top/bili ; 
yixing_cankao_bot = yixing_cankao_bot/bili ;

v = camber_cankao ; 
[v2,C] = get_zhonghuxian(chi_in,chi_out,k,xi,vpp);
% bianliang = [v(:,1) v2(:,2)-v(:,2)]
bianliang  = subtract_2disparate(v,v2);
% ������Ҫ��һ�����ڡ��������й��ɵ�����������ǵĲ�����С������Ķ�����
% 
% huatu2(camber_cankao) ; huatu2(v2); huatu2(v_m);

% shuchu2 ���������Ĵ��룬Ϊ����ͷ����֤�ܵ���
%�����ֱ�Ӵ���ɶ���ʽ���ˡ�Ȼ������ڶԱȵĶ���Ҳ�����ȥ��Ҳ��
s = 'v_m';
file = [wenjianming '\' s '.txt'] ; 
file_cankao = [wenjianming '\' s '.dat'] ; 

p_bianliang = polyfit(bianliang(:,1),bianliang(:,2),4) ;
% ���׶���ʽ������ˡ�Ҫ�Ľ���ʵҲ���ǲ����
% �Ľ׵��ܺò��٣������Ľ׵İɡ�get_zhonghuxian_m����Ҳ����Ӧ�ĸġ�
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