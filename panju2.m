function zhi = panju2(uv_top_r,uv_bot_r,qianyuan,qianyuan_d,qianyuan_d2)
%这个是用来计算判据的。不要偷懒，所以还是隔离出来弄一个函数了。
n_qianyuan_top = n_danwei(qianyuan) ; 
n_uv_top = -1*n_danwei(uv_top_r) ;

n_uv_bot = -1*n_danwei(uv_bot_r) ;
n_qianyuan_bot= n_danwei(flipud(qianyuan)) ; 

panju_top = n_qianyuan_top * n_uv_top' ; 
panju_bot = n_qianyuan_bot * n_uv_bot' ;

if(~((panju_top>0)&&(panju_bot>0)))
%     fprintf('炸了，上表面出大问题。');
    fprintf('MXairfoil:炸了，至少有一个地方是出现了错误的方向了。\n');
end
% if(panju_bot<0)
%     fprintf('炸了，下表面出大问题。');
% end

panju_1 = ((panju_top>0)&(panju_bot>0))*norm(panju_top,2)*norm(panju_bot,2) ; %综合起来，要有一个是负的就是负的，且大小还要保单调性。
R = abs((1+(qianyuan_d(:,1)./qianyuan_d(:,2)).^2).^(3/2)./(qianyuan_d2(:,1)./qianyuan_d2(:,2))) ; 
K =1./R ; 

%尝试在这里加一步手动的光顺化
if(1)
    [hangshu , ~] = size(K) ; 
    for i=2:hangshu-1
        if(K(i)>((K(i-1)+K(i+1))*5))
            K(i)=((K(i-1)+K(i+1))*1);
            %突变的点直接杀了
        end
    end
end


%

K_max = find(K==max(K)) ; 
% zhi = max(K) ;
% shishi = R.*panju_1 ; 
% zhi = sum(1./shishi(50:150,:)) ; 
% zhi = sum(1./shishi) ; 


zhi = abs(K_max(1)-100)/panju_1 ; 
% zhi = abs(K_max(1)-100) ; 
if(0)
    figure(1);
    hold on ;
    plot(K);
end


end

function zhi = n_danwei(qianyuan)
%就求解个单位矩阵了。
P1 = qianyuan(1,:) ; 
P2 = qianyuan(2,:) ; 
n = P2-P1 ; 
n = n/norm(n,2);
zhi = n ; 

if(0)
    huatu2([P1 ; P1+n]) ; 
end
end