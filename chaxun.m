function zhi = chaxun(houdu,u)
%弄一个从厚度分布里面查询厚度的东西，输入u，输出v.
%简单点弄一弄吧，就不去盘什么的高阶的插值啊什么jb的那些了。
% 也不扯那些奇奇怪怪的搜索方法了。
[hang lie] = size(houdu) ; 
for i=1:hang-1
    if((u>=houdu(i,1))&&(u<=houdu(i+1,1)))
        zhi = (houdu(i+1,2) - houdu(i,2))*(u - houdu(i,1))/...
            (houdu(i+1,1) - houdu(i,1))+houdu(i,2);
        zhi = abs(zhi) ; 
        return ;
    end
    if((u>=houdu(i+1,1))&&(u<=houdu(i,1)))%多弄一个让它倒序的序列也能查
        zhi = (houdu(i+1,2) - houdu(i,2))*(u - houdu(i,1))/...
            (houdu(i+1,1) - houdu(i,1))+houdu(i,2);
        zhi = abs(zhi) ; 
        return ;
    end
    if(u==1)%处理一下最远端的点
        zhi = abs(houdu(end))*0.7 ; 
        %这个0.7是脑补的，没什么依据。
        return ; 
    end
end 
fprintf('凉了，并不在能插值的范围内\n ');
zhi = 0 ;  
end 