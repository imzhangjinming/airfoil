function [uv_top2 , uv_bot2] = get_qianyuan5(uv_top,uv_bot,lethk,chi_in)
%2021��3��28�ռӳ���֮ǰ�����������ȶ��Ե��о�֮���õĽ����
% ���������ҪԲ���ȶ��������öࡣȻ����Ȼ�����������ã���Ϊ���ǻ�������ֵֹĶ�����
i=1 ; 
P1 = uv_top(i,1:2) ; 
P2 = uv_bot(i,1:2) ; 
while((norm(P1-P2,2)<0.001)&&(i<10))
    %��һ���ݴ���ƣ���Ȼ�����㿿��̫���˾�ֱ��ը�ˡ�
    P1 = uv_top(i,1:2) ; 
    P2 = uv_bot(i,1:2) ; 
    i=i+1 ; 
end

P3 = (P1+P2)/2 + lethk*[cos(chi_in) sin(chi_in)]*(-0.5) ; 

% dvdu_top = weifen2(uv_top) ;
% d2vdu2_top = weifen2(uv_top) ;
% d3vdu3_top = weifen2(uv_top) ;
dvdu_top = weifen_uv(uv_top) ; %��������������һ���ģ�������һЩά���ϵĲ��
d2vdu2_top = weifen_uv(dvdu_top) ;
d3vdu3_top = weifen_uv(d2vdu2_top) ;

dvdu_bot = weifen_uv(uv_bot) ;
d2vdu2_bot = weifen_uv(dvdu_bot) ;
d3vdu3_bot = weifen_uv(d2vdu2_bot) ;

% fprintf('MXairfoil: �ⲿ�ֻ�û��д�� \n')
[qianyuan,qianyuan_d,qianyuan_d2] = search_Bspline4_2seg(...
    P1(1,1) , P1(1,2) , P2(1,1) , P2(1,2),...
    dvdu_top(2,2) ,d2vdu2_top(1,2),d3vdu3_top(1,2),...
    dvdu_bot(1,2),d2vdu2_bot(1,2) ,d3vdu3_bot(1,2),...
    P3(1,1), P3(1,2),uv_top(:,1:2),uv_bot(:,1:2)) ;

% huatu2(uv_top);huatu2(uv_bot);huatu2(P3);% huatu2(qianyuan);
% fprintf('MXairfoil: �ⲿ�ֻ�û��д�� \n')

%��������Ҫ���·ֵģ����ص��ⲽ����һ�㽲����û��ʲô��ϵ�ա�
%����������Ҳ�Ͷ�һ���ˣ������ֲ�Ӱ��Ŀ���
[hang,~] = size(qianyuan) ; 
% uv_top2 = [flipud(qianyuan(1:hang/2,:)) zeros(hang/2,2) ; uv_top]  ; 
% uv_bot2 = [qianyuan(hang/2:end,:) zeros(hang/2+1,2) ; uv_bot]  ;
%�Ӻ����д�����������񲢲���Ҫ����������С�Ҳ�Ǻ��°ɡ�
uv_top2 = [flipud(qianyuan(1:hang/2,:)) ; uv_top(:,1:2)]  ; 
uv_bot2 = [qianyuan(hang/2:end,:) ; uv_bot(:,1:2)]  ;

end