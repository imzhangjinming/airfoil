function zhi = get_circleEdge(xyzC3,xyzS1,xyzS2,R)
% 保持了一些通用性，不然的话直接九十度其实应该也行。
V1 = xyzS1 - xyzC3 ; 
flag1 = sign(V1(1,1)) ; 
jiaodu1 = atan(V1(1,3)/V1(1,1)) ; 
if(flag1<0)
    jiaodu1 = jiaodu1+pi ;
end 
V2 = xyzS2 - xyzC3 ;
flag2 = sign(V2(1,1)) ; 
jiaodu2 = atan(V2(1,3)/V2(1,1)) ; 
if(flag2<0)
    jiaodu2 = jiaodu2+pi ;
end 

% R = norm(xyzS1-xyzS2 , 2) /2 ; 
% canshu = min(jiaodu1,jiaodu2):...
%     0.1*abs(max(jiaodu1,jiaodu2)-min(jiaodu1,jiaodu2)):...
%     max(jiaodu1,jiaodu2) ; 
if(jiaodu1<jiaodu2)
    jiaodu1 = jiaodu1+2*pi ; 
%     jiaodu2 = jiaodu2+pi ; 
end
canshu = jiaodu2:...
    0.1*abs(max(jiaodu1,jiaodu2)-min(jiaodu1,jiaodu2)):...
    jiaodu1 ; 
canshu = canshu' ; 

zhi = [xyzC3(1,1)+cos(canshu).*R,xyzC3(1,2)+canshu.*0,xyzC3(1,3)+sin(canshu).*R];

end