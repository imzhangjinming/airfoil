function zhi = get_houdum(wenjianming)
% ���������дһ��ר����Ū����v_m�ģ���ȡ����֮����P_m������Ȼ���ɵĲ��ֺ����������һ���ֱ���˹��ˡ�
% �䱾����fuke_yixing2
wenjianming ='..\input\CDA1' ; 
[chi_in,chi_out,xi,vpp,vp,bili,...
lecurv,tecurv,lethk,tethk,umxthk,mxthk,...
beta_in1 , beta_out1,houdu_cankao,H_pingyi,L_pingyi,...
p_houdu,p_camber,p_m] = dataInput2(wenjianming);

k=1 ; %��Ϊ��ֱ�ӷ����ȥ������k�͵���1��������

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

% �ȴ���ǰ��һ��
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
% ������Ҫ��һ�����ڡ��������й��ɵ�����������ǵĲ�����С������Ķ�����

% shuchu2 ���������Ĵ��룬Ϊ����ͷ����֤�ܵ���
%�����ֱ�Ӵ���ɶ���ʽ���ˡ�Ȼ������ڶԱȵĶ���Ҳ�����ȥ��Ҳ��
s = 'houdu_m';
file = [wenjianming '\' s '.txt'] ; 
file_cankao = [wenjianming '\' s '.dat'] ; 

p_qian = polyfit(bianliang_qian(:,1),bianliang_qian(:,2),3) ;
p_hou = polyfit(bianliang_hou(:,1),bianliang_hou(:,2),3) ;
p_bianliang = [p_qian,p_hou];
% ���׶���ʽ������ˡ���ʵ�����Ѿ������ˡ��Ͼ��Ƿ������εġ�
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