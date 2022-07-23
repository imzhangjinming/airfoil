function [uv_top2 , uv_bot2] = get_qianyuan5(uv_top,uv_bot,lethk,chi_in)
%2021年3月28日加持了之前对样条曲线稳定性的研究之后获得的结果。
% 这个试下来要圆润、稳定和连续得多。然而仍然不足以拿来用，因为还是会变成奇奇怪怪的东西。
i=1 ; 
P1 = uv_top(i,1:2) ; 
P2 = uv_bot(i,1:2) ; 
while((norm(P1-P2,2)<0.001)&&(i<10))
    %搞一点容错机制，不然两个点靠的太近了就直接炸了。
    P1 = uv_top(i,1:2) ; 
    P2 = uv_bot(i,1:2) ; 
    i=i+1 ; 
end

P3 = (P1+P2)/2 + lethk*[cos(chi_in) sin(chi_in)]*(-0.5) ; 

% dvdu_top = weifen2(uv_top) ;
% d2vdu2_top = weifen2(uv_top) ;
% d3vdu3_top = weifen2(uv_top) ;
dvdu_top = weifen_uv(uv_top) ; %这两个基本上是一样的，顶多有一些维度上的差别。
d2vdu2_top = weifen_uv(dvdu_top) ;
d3vdu3_top = weifen_uv(d2vdu2_top) ;

dvdu_bot = weifen_uv(uv_bot) ;
d2vdu2_bot = weifen_uv(dvdu_bot) ;
d3vdu3_bot = weifen_uv(d2vdu2_bot) ;

% fprintf('MXairfoil: 这部分还没有写完 \n')
[qianyuan,qianyuan_d,qianyuan_d2] = search_Bspline4_2seg(...
    P1(1,1) , P1(1,2) , P2(1,1) , P2(1,2),...
    dvdu_top(2,2) ,d2vdu2_top(1,2),d3vdu3_top(1,2),...
    dvdu_bot(1,2),d2vdu2_bot(1,2) ,d3vdu3_bot(1,2),...
    P3(1,1), P3(1,2),uv_top(:,1:2),uv_bot(:,1:2)) ;

% huatu2(uv_top);huatu2(uv_bot);huatu2(P3);% huatu2(qianyuan);
% fprintf('MXairfoil: 这部分还没有写完 \n')

%反正后面要重新分的，返回的这步随意一点讲道理没有什么关系罢。
%甚至点数多也就多一点了，反正又不影响的咯。
[hang,~] = size(qianyuan) ; 
% uv_top2 = [flipud(qianyuan(1:hang/2,:)) zeros(hang/2,2) ; uv_top]  ; 
% uv_bot2 = [qianyuan(hang/2:end,:) zeros(hang/2+1,2) ; uv_bot]  ;
%从后面的写法来看，好像并不需要输出后面两列。也是好事吧。
uv_top2 = [flipud(qianyuan(1:hang/2,:)) ; uv_top(:,1:2)]  ; 
uv_bot2 = [qianyuan(hang/2:end,:) ; uv_bot(:,1:2)]  ;

end