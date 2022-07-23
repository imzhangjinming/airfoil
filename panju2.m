function zhi = panju2(uv_top_r,uv_bot_r,qianyuan,qianyuan_d,qianyuan_d2)
%��������������оݵġ���Ҫ͵�������Ի��Ǹ������Ūһ�������ˡ�
n_qianyuan_top = n_danwei(qianyuan) ; 
n_uv_top = -1*n_danwei(uv_top_r) ;

n_uv_bot = -1*n_danwei(uv_bot_r) ;
n_qianyuan_bot= n_danwei(flipud(qianyuan)) ; 

panju_top = n_qianyuan_top * n_uv_top' ; 
panju_bot = n_qianyuan_bot * n_uv_bot' ;

if(~((panju_top>0)&&(panju_bot>0)))
%     fprintf('ը�ˣ��ϱ���������⡣');
    fprintf('MXairfoil:ը�ˣ�������һ���ط��ǳ����˴���ķ����ˡ�\n');
end
% if(panju_bot<0)
%     fprintf('ը�ˣ��±���������⡣');
% end

panju_1 = ((panju_top>0)&(panju_bot>0))*norm(panju_top,2)*norm(panju_bot,2) ; %�ۺ�������Ҫ��һ���Ǹ��ľ��Ǹ��ģ��Ҵ�С��Ҫ�������ԡ�
R = abs((1+(qianyuan_d(:,1)./qianyuan_d(:,2)).^2).^(3/2)./(qianyuan_d2(:,1)./qianyuan_d2(:,2))) ; 
K =1./R ; 

%�����������һ���ֶ��Ĺ�˳��
if(1)
    [hangshu , ~] = size(K) ; 
    for i=2:hangshu-1
        if(K(i)>((K(i-1)+K(i+1))*5))
            K(i)=((K(i-1)+K(i+1))*1);
            %ͻ��ĵ�ֱ��ɱ��
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
%��������λ�����ˡ�
P1 = qianyuan(1,:) ; 
P2 = qianyuan(2,:) ; 
n = P2-P1 ; 
n = n/norm(n,2);
zhi = n ; 

if(0)
    huatu2([P1 ; P1+n]) ; 
end
end