function yuanxin = get_yuanxin(line1,line2,R,cankao)
% 这个是安排一个求和两条相切的直线求切点的东西，相对来说是比较普适了。
% 求出来的四个圆心里面要

    fenmu1 = sqrt(line1.a^2 + line1.b^2) ; 
    fenmu2 = sqrt(line2.a^2 + line2.b^2) ; 
    
    zhengfuhao = [-1,-1;-1,1;1,-1;1,1] ; 
    jieguo = zeros(4,2);
    
    xishu0 = [line1.a , line1.b ,line1.c;...
        line2.a , line2.b , line2.c] ; 
    xishu0(1,:) = xishu0(1,:)./fenmu1 ; 
    xishu0(2,:) = xishu0(2,:)./fenmu2 ; 
    
    jvli = zeros(4,1) ; 
    
    for i=1:4    
        xishu = [xishu0(1,1:2).*zhengfuhao(i,1) ; ...
            xishu0(2,1:2).*zhengfuhao(i,2)] ; 
        youbian = [R - xishu0(1,3)*zhengfuhao(i,1)  ;...
            R - xishu0(2,3)*zhengfuhao(i,2)] ; 
        jieguo(i,:) = mldivide(xishu,youbian)' ; 
        jvli(i) = norm((jieguo(i,:)-cankao),2) ; 
    end 
    index = find(jvli==min(jvli)) ; 
    yuanxin = jieguo(index,:) ; 
end 